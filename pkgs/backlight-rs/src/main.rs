static DEVICE_PATH: &str = "/sys/class/backlight/intel_backlight";
static E: f64 = 2.7182818284;

fn main() -> Result<(), String> {
    let args: Vec<String> = std::env::args().collect();
    let cmd_name = args[0].as_str();

    if args.len() <= 1 {
        print_help(cmd_name);
        return Ok(());
    }

    let value: Option<f64> = if args.len() > 2 {
        args[2].parse::<f64>().ok()
    } else {
        None
    };
    
    match args[1].as_str() {
        "-get" => {
            println!("{}", get_brightness().round());
            Ok(())
        },
        "-set" => set_brightness(value),
        "-inc" => inc_brightness(value),
        "-dec" => dec_brightness(value),
        _ => {print_help(cmd_name); Ok(())}
    }
}

fn read_backlight(path: &str) -> u32 {
    return std::fs::read_to_string(format!("{}/{}", DEVICE_PATH, path))
        .expect("path should exist")
        .trim()
        .parse::<u32>()
        .expect("Value should be number");
}

fn set_backlight(path: &str, value: &str) -> std::io::Result<()> {
    std::fs::write(format!("{}/{}", DEVICE_PATH, path), value)
}

fn print_help(cmd_name: &str) {
    println!("usage: {} [-get] [-inc PERCENT] [-dec PERCENT] [-set PERCENT]", cmd_name);
}

fn get_brightness() -> f64 {
    let percentage = read_backlight("brightness") as f64 / read_backlight("max_brightness") as f64;
    return percentage.powf(1.0/E) * 100.0;
}

fn set_brightness(value: Option<f64>) -> Result<(), String> {
    let percent = validate(value)?;
    let new_value = (percent / 100.0).powf(E) * read_backlight("max_brightness") as f64;
    set_backlight("brightness", new_value.round().to_string().as_str()).expect("Should set brightness");
    Ok(())
}

fn inc_brightness(value: Option<f64>) -> Result<(), String> {
    let percent = validate(value)?;
    let old_percentage = get_brightness();
    let new_percentage = f64::min(percent + old_percentage, 100.0);
    set_brightness(Some(new_percentage))
}

fn dec_brightness(value: Option<f64>) -> Result<(), String> {
    let percent = validate(value)?;
    let old_percentage = get_brightness();
    let new_percentage = f64::max(old_percentage - percent, 0.0);
    set_brightness(Some(new_percentage))
}

fn validate(value: Option<f64>) -> Result<f64, String> {
    if value.is_none() {
        return Err(String::from("Value must be within 0 and 100"));
    }
    let percent = value.unwrap();
    if percent > 100.0 || percent < 0.0 {
        return Err(String::from("Value must be within 0 and 100"));
    }
    Ok(percent)
}
