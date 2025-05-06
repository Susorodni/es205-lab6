function err = Error_Mag(s,Rp,mag_data,C,R)
    Giw = -C*R*(Rp+100)*s./( (C^2)*(R^2)*(Rp+100)*s.^2 + C*R*(Rp+100)*s +(R+Rp+100)/2 );
    magGiw = abs(Giw);

    err = sum((mag_data-magGiw).^2);