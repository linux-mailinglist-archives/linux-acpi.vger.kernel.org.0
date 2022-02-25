Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E90F4C4E49
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Feb 2022 20:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234132AbiBYTGF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 25 Feb 2022 14:06:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233574AbiBYTGA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Feb 2022 14:06:00 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991C81BAF23;
        Fri, 25 Feb 2022 11:05:27 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 5AC901F46678
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645815926;
        bh=j7Rs/2nX9khQjgsPMQj22DMvM8jq4/YkmhOJrRks6X8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dn6fmsTljjuk1WXUGzVYnT7CkOMRl2hSZQrzzQTUfnNPGHA/iy3CZuO70o4E5vk8i
         exoic4KSIxTQYFAShvuFpYJW6/3zELrjV4x+gJ0Y29SeZ9ya4yix2OjtGO3wFOjMhS
         +ysVh0BKspJeNB5TbWhrcJERPFk4sbq9vlbo8Kc5OultRq+7evKGT9jKiD9QDkG8HA
         RtbiAQtp1xsllk6HZd2+3BZnjWn/7DOAvxE/wuBLFQlKO2hytTvLzV179/J529fuR6
         I6tFl9kt4OjHuNIIkf+BC+FWxDQDYD44xbHPjRWaoI9fuMfegB+CaNrgWkXK0FewYY
         SpgfhCCaraBpQ==
Received: by mercury (Postfix, from userid 1000)
        id 1B36E106049B; Fri, 25 Feb 2022 20:05:22 +0100 (CET)
Date:   Fri, 25 Feb 2022 20:05:22 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Carl Edquist <edquist@cs.wisc.edu>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Thomas Renninger <trenn@suse.de>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: /proc/acpi/battery gone again, breaks wmpower
Message-ID: <20220225190522.cbqoxpsucvniep55@mercury.elektranox.org>
References: <0718fe87-230f-b293-b998-b83f3c133367@cs.wisc.edu>
 <CAJZ5v0j=c-ctwqmRfvVtep4DtOf=6Gf=zs+B19aPDpQ0447oRw@mail.gmail.com>
 <CAJZ5v0h5D=1UWqmC=foAK3-p1LLV=KG8dRM-kPYxJc7GEKdZbQ@mail.gmail.com>
 <448277be-d848-d4dd-2d92-1b4e6ea69243@cs.wisc.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kfzai5ypy2tmllxf"
Content-Disposition: inline
In-Reply-To: <448277be-d848-d4dd-2d92-1b4e6ea69243@cs.wisc.edu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


--kfzai5ypy2tmllxf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

(I will leave the ACPI related questions for Rafael, but
can try to help with some of the questions)

On Thu, Feb 24, 2022 at 10:53:32AM -0600, Carl Edquist wrote:
> My thoughts about this though -
>=20
> I did not really expect to get this interface back after I read the commit
> message for its removal. I admire your fidelity to the linux user promise,
> but I don't want to create trouble for you guys either.
>=20
> I am happy to put in the legwork to get wmpower working using whatever the
> blessed replacement is for the acpi procfs power stuff.  Maybe you can he=
lp
> shed some light on the sysfs interface for me.

FWIW the power-supply sysfs API exists since quite some time now
(4a11b59d8283 from 2007), so it's not particularly new ;)

> I started exploring a bit under /sys/class/power_supply, looking for
> replacements for the "present rate" and "last full/remaining capacity" it=
ems
> under /proc/acpi/battery.  Curiously I have two lenovo ThinkPads, a T510 =
and
> a T540p, and one of them has current_now & charge_full/_now, and the other
> has power_now & energy_full/_now.  Are these the only two possibilities f=
or
> rate & capacity?  Or are there other potentially others?

That is because the power-supply subsystem passes through
the data provided by the hardware without unit conversion.
So one of the battery fuel gauges in your laptops provides
its numbers in Wh and one provides it in Ah. In (non ACPI)
embedded systems you might also get neither of them.

The units for the sysfs files are fixed, so a system reporting
Ah provides current_now/charge_now files and Wh based systems
provide power_now/energy_now files.

> I guess the convenient thing about the /proc/acpi/battery interfaces is t=
hat
> it automatically presents the right info for rate & capacity.
>=20
> (I felt like I was losing my mind for a bit when I saw the units presented
> as "mAh" in one after I was sure I had read "mWh" before... But reading y=
our
> patch helped give me a better clue about what was going on there.)

The files in /sys/class/power_supply always report almost all values
in =B5 units (i.e. =B5A, =B5V, =B5Ah, =B5W, ...), one value per file and wi=
th
fixed units. Documentation can be found here:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Doc=
umentation/ABI/testing/sysfs-class-power

> I'm also curious, is the "BAT[0-*]" pattern for battery names consistent,=
 or
> are there other possibilities?  I had suspected "AC" was the standard
> power_supply name for the main AC power, but that turned out not to be the
> case on another (HP) laptop that I took a look at.  Which leads me to
> suspect that "BATX" is not necessarily standard either.

The subsystem does not have any name constraints. But you can find
the device type via the 'type' file and non-system level devices
(e.g. battery of a game controller) set the 'scope' property to
"Device".

> I'm also thinking to enumerate batteries & AC power supplies via
> /sys/bus/acpi/drivers/{ac,battery} rather than /sys/class/power_supply, as
> surprisingly even a USB-C stick can show up under power_supply, and it's =
not
> obvious if there's a clean way to sort out what's what then.

USB-C is kind of tricky with the option to reverse power-flow in
many cases (e.g. laptop can charge a power bank or power bank can
charge a laptop using the same connector). In general you definetly
can get non-ACPI power-supply devices, e.g. batteries from wireless
keyboards.

Also some devices have broken ACPI battery handling, so the ACPI
driver is blacklisted and native hardware drivers are used
instead. In that case you will not find anything power related
in /sys/bus/acpi.

-- Sebastian

> I say all this of course as a laptop end-user, and even with the kernel
> source docs in front of me I seem to be feeling my way around in the dark=
=2E I
> don't know much about the linux acpi internals, and I did not learn about
> the acpi procfs power interface being deprecated until after wmpower stop=
ped
> working for me this month :)
>=20
> It seems like part of the difficulty is that there is not much of a feedb=
ack
> loop for end users to realize that they are using deprecated procfs
> interfaces, whether directly in custom battery scripts that scrape
> /proc/acpi/battery, or unwittingly through other programs they happen to =
use
> (in this case wmpower).  There are no warnings until it's too late.
>=20
> And even taking a look at what happened the first time it was removed [1],
> it seems the conclusion was "some people are still using programs that re=
ly
> on the interface, so we'll add it back" ... But it's not obvious if any
> effort was made to contact maintainers with a little nudge, to let them k=
now
> that it's (still) deprecated and what the replacement interface is.
>=20
> Not sure what the general solution is there, but in any case I'll cheerfu=
lly
> fix up wmpower.
>=20
>=20
> Thanks again and sorry for the long mail :)
>=20
> Carl
>=20
>=20
> [1] https://lkml.org/lkml/2014/4/21/152

>   CC [M]  drivers/acpi/ac.o
> In file included from ./include/linux/kernel.h:29,
>                  from drivers/acpi/ac.c:11:
> drivers/acpi/ac.c: In function 'acpi_ac_add_fs':
> drivers/acpi/ac.c:182:29: error: expected ')' before 'PREFIX'
>   182 |         printk(KERN_WARNING PREFIX "Deprecated procfs I/F for AC =
is loaded,"
>       |                             ^~~~~~
> ./include/linux/printk.h:418:25: note: in definition of macro 'printk_ind=
ex_wra'
>   418 |                 _p_func(_fmt, ##__VA_ARGS__);                    =
       \
>       |                         ^~~~
> drivers/acpi/ac.c:182:9: note: in expansion of macro 'printk'
>   182 |         printk(KERN_WARNING PREFIX "Deprecated procfs I/F for AC =
is loaded,"
>       |         ^~~~~~
> ./include/linux/printk.h:418:24: note: to match this '('
>   418 |                 _p_func(_fmt, ##__VA_ARGS__);                    =
       \
>       |                        ^
> ./include/linux/printk.h:446:26: note: in expansion of macro 'printk_inde=
x_wrap'
>   446 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_A=
RGS__)
>       |                          ^~~~~~~~~~~~~~~~~
> drivers/acpi/ac.c:182:9: note: in expansion of macro 'printk'
>   182 |         printk(KERN_WARNING PREFIX "Deprecated procfs I/F for AC =
is loaded,"
>       |         ^~~~~~


--kfzai5ypy2tmllxf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmIZKGsACgkQ2O7X88g7
+po3HhAAmVBYC/youNeitvXCCP8tqCGqGCIdEPd8C9aKazidv2xPqr9zNxysNhcP
lfUJxZZ1RXmOYUNSFiCAzcZj6V0m4qa5uRg0p/kRPbOSTQezocyfWlSlWbSLjjpM
311bOT+/NDjRemNKu1vQZoVoS1Rr+pgjIgy5JLkXxMifAtqbR9iC/edRSVc68GST
cyPAecTrfqe3TildG198jxUczVuPxGux23wi8huM2cqVRYbn70QoeFBfW30r8tcA
5y+I6BPlc4N40rwykllzO3XiVDkf46r3U/Ct7qSCzw8fAJqOBMGdjqtPml9+ZHkI
VU+kfRzCxzKj84JqFXFdDtxw2f9xkZMlb9D8u44YKQFSBpnTPn6VKyAhRmFOzTLF
YADhWg3M4qOn00gwzas7+kKk8JZBVGyCw1ESsQRaPQiVO2L6qG2IBCx/KcMmsqGJ
XDO6l58orxY+llKaovS2uQEEr99mvM44EZu3EyoHahoPUDG8e5zj2OxNApA9ULdF
aBLqQubp/FpNgzePX7OJ/rk3xeO1qigvUJNwoKbchHCIKomGS2wEnyPmvMKS+ERm
qPpW4ZDp3qdok/Zd61kjXqWKJz6EoD0KILSE8hXqzRo8ZyyqRO7gg0EiTvup/VXG
f8FS3k1lxl6D10qO6TMLAJv320+Rvb9P/44Fp2n8wNT4BKV+luk=
=+ddv
-----END PGP SIGNATURE-----

--kfzai5ypy2tmllxf--
