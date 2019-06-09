Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC4F43A643
	for <lists+linux-acpi@lfdr.de>; Sun,  9 Jun 2019 15:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728534AbfFINz3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 9 Jun 2019 09:55:29 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:36147 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727698AbfFINz3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 9 Jun 2019 09:55:29 -0400
Received: by mail-wr1-f54.google.com with SMTP id n4so6563154wrs.3
        for <linux-acpi@vger.kernel.org>; Sun, 09 Jun 2019 06:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=D8Gq6RkvKnje3OaNdNLglZuoNIMD3Yqhw5B6pJRQYg4=;
        b=IxafZuLDZ0wlbhCCk92zqQfl24SvJsJbl+kSci0phkai450DP0Es7+3lWrHvSxjsF6
         7pjY3WSeXb59tHriKskllRfo7BDiiUS9cnVncP+7sImCjEcntbQ5hmwgEiWnyDfVeRyX
         ZNUyX/GVizUKLHPu2iDAfAmgOLwfQqlZxnxS1Im9x96WSApXEti6EQhxykAqGSLvKPWw
         UqtPYurJyqGqPpuRWsCfIy4uRtzmAsO/59d+Vr+TVkEDE+l34A9A+v6CQy3QFgU4gbvD
         L3pC/0yy99WOx8NTgMf5uJDtEwyrjUp3He4UZnIS1ZHXJmVv9oiQXZg858+lUPCqnrdB
         ZVkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=D8Gq6RkvKnje3OaNdNLglZuoNIMD3Yqhw5B6pJRQYg4=;
        b=bK7Sw2tJylnyjFFFiW+sbuD+RLJJ+2QJOgBK1kpegNj7dJCMrUOdm3FjeuJfVqV1wc
         pfiUsDZz/8QDhCaCLsaF3VrUYV3iS+KpILhmX2GeK2fyRyMTMcREX/s0jKXpToVikRJO
         2+l9N2WiudOLWSmMniXGNsb1mxhvPY8fDOfudfwu34KKub84mIKvRx5BTmhCHosQb+j9
         FhgW6WXqptxQ+g5YzEps2J/cavkpyyK1grFH9EbhOKyPG+476nKcTDm4e+Jy+EiUlNLA
         p5duqwt2GNoIKazlCr1N6pXZuulG5extVf/CR/ZEBZRtDeKmXtw/V+WuffpCFbG3Q/mH
         lncA==
X-Gm-Message-State: APjAAAXttxt3jSlA+YvcIvM0OLneopimqy7qlm1f80UIC/ZsSK0jZWBe
        qOUQvILBG6ECShCMjusuxbPRzA==
X-Google-Smtp-Source: APXvYqyi7WUcUYdLfo7GERFafTz8bug8c9O30zjJLm3jBHyxZsAJgQ/+mEzoYCDvZUbib08yy9z17g==
X-Received: by 2002:adf:baca:: with SMTP id w10mr31888337wrg.230.1560088526020;
        Sun, 09 Jun 2019 06:55:26 -0700 (PDT)
Received: from [192.168.0.41] (149.71.129.77.rev.sfr.net. [77.129.71.149])
        by smtp.googlemail.com with ESMTPSA id h90sm18183538wrh.15.2019.06.09.06.55.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Jun 2019 06:55:25 -0700 (PDT)
Subject: Re: 5.2-rc2: low framerate in flightgear, cpu not running at full
 speed, thermal related?
To:     Pavel Machek <pavel@ucw.cz>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-acpi@vger.kernel.org, rui.zhang@intel.com, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org
References: <20190609111732.GA2885@amd> <20190609112340.GA9966@amd>
 <20190609121212.GA4520@amd>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <22d57953-b032-6090-8efb-4e1d2add1b69@linaro.org>
Date:   Sun, 9 Jun 2019 15:55:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190609121212.GA4520@amd>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="794WAxFRhf8xkHQTT2UXTfeQTnVbfhpY3"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--794WAxFRhf8xkHQTT2UXTfeQTnVbfhpY3
Content-Type: multipart/mixed; boundary="COZGpQjNCMAL20GInMGKgxRHTw820uY9V";
 protected-headers="v1"
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
 linux-acpi@vger.kernel.org, rui.zhang@intel.com, rjw@rjwysocki.net,
 viresh.kumar@linaro.org, linux-pm@vger.kernel.org, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org
Message-ID: <22d57953-b032-6090-8efb-4e1d2add1b69@linaro.org>
Subject: Re: 5.2-rc2: low framerate in flightgear, cpu not running at full
 speed, thermal related?
References: <20190609111732.GA2885@amd> <20190609112340.GA9966@amd>
 <20190609121212.GA4520@amd>
In-Reply-To: <20190609121212.GA4520@amd>

--COZGpQjNCMAL20GInMGKgxRHTw820uY9V
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 09/06/2019 14:12, Pavel Machek wrote:
> Hi!
>=20
>>> When I start flightgear, I get framerates around 20 fps and cpu at
>>> 3GHz:
>>>
>>> pavel@duo:~/bt$ cat /proc/cpuinfo  | grep MHz
>>> cpu MHz		    : 3027.471
>>> cpu MHz		      : 2981.863
>>> cpu MHz		      	: 2958.352
>>> cpu MHz			  : 2864.001
>>> pavel@duo:~/bt$
>>>
>>> (Ok, fgfs is really only running at single core, so why do both cores=

>>> run at 3GHz?)
>>>
>>> But temperatures get quite high:
>>>
>>> pavel@duo:~/bt$ sensors
>>> thinkpad-isa-0000
>>> Adapter: ISA adapter
>>> fan1:        4485 RPM
>>>
>>> coretemp-isa-0000
>>> Adapter: ISA adapter
>>> Package id 0:  +98.0=C2=B0C  (high =3D +86.0=C2=B0C, crit =3D +100.0=C2=
=B0C)
>>> Core 0:        +98.0=C2=B0C  (high =3D +86.0=C2=B0C, crit =3D +100.0=C2=
=B0C)
>>> Core 1:        +91.0=C2=B0C  (high =3D +86.0=C2=B0C, crit =3D +100.0=C2=
=B0C)
>>>
>>> And soon cpu goes to 1.5GHz range, with framerates going down to
>>> 12fps. That's a bit low.
>>>
>>> Room temperature is 26Celsius.
>>>
>>> The CPU is Intel(R) Core(TM) i5-2520M CPU @ 2.50GHz . I guess it mean=
s
>>> it should be able to sustain both cores running at 2.5GHz?
>>>
>>> Any ideas? Were there any recent changes in that area?
>>
>> I tried kernel compile. It keeps both cores at 3GHz, temperature goes
>> up over 95C, and then cpus start going down to 2.3GHz... and then down=

>> to 2GHz... and down to 1.9GHz.
>>
>> watch bash -c 'sensors;  cat /proc/cpuinfo | grep MHz'
>=20
> Situation is very different with v4.6 distro based kernel.
>=20
> CPU MHz is only getting values round to 100MHz. It does not go above
> 2.5GHz, but it does not go below 2.5GHz under the load, either.
>=20
> ACPI adapter appears in sensors output.
>=20
> Now I tried going to 5.2-rc4. It behaves the same as 5.2-rc2. Goes up
> to 3GHz briefly but then down to 2.0GHz and below under load.
>=20
> Ideas welcome.

What is the cpufreq governor for v4.6 and v5.2-rc4?



--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for A=
RM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog



--COZGpQjNCMAL20GInMGKgxRHTw820uY9V--

--794WAxFRhf8xkHQTT2UXTfeQTnVbfhpY3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEGn3N4YVz0WNVyHskqDIjiipP6E8FAlz9D8kACgkQqDIjiipP
6E/LYwgAqrTwxtZaBPNSoTB3pNaosqY79Pptt/v/E1Au21npx6sTQe0DwWbFFB/m
cFtNEOWI53EbX+NS+a0O2JtCta8xsu26JAbALMxI/qIUkGA6mUUR7/LzfyA0RylC
UsZ7++D7kFlofpu6S6usgch1PSVKdujACytjvgjxUD51qGJ/gLcxt0MdlVXi4Kmk
NsRVH9iAecGJeP6MQfwWLewgYg8cKQu6HFT+ARQ+33rEwh/42ch4DDX+5M8OQN8G
2Wp7TOKT6pNap0aK9qRwohp/NzBRluEFR0dbe+V+ZThT/7zZtnwsXdX6AB9PN6Un
dXY537drTfAAjmEiSF32t79aAw9Ytg==
=9QNq
-----END PGP SIGNATURE-----

--794WAxFRhf8xkHQTT2UXTfeQTnVbfhpY3--
