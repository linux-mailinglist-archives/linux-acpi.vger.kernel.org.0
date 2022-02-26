Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE9A94C57C1
	for <lists+linux-acpi@lfdr.de>; Sat, 26 Feb 2022 20:03:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbiBZTER (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 26 Feb 2022 14:04:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbiBZTEQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 26 Feb 2022 14:04:16 -0500
Received: from smtpout2.cs.wisc.edu (smtpout2.cs.wisc.edu [128.105.6.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2943673C0;
        Sat, 26 Feb 2022 11:03:40 -0800 (PST)
Received: from mystras.cs.wisc.edu (mystras.cs.wisc.edu [128.105.14.41])
        by flint.cs.wisc.edu (8.14.7/8.14.4) with ESMTP id 21QJ3Lmo013624;
        Sat, 26 Feb 2022 13:03:21 -0600
DKIM-Filter: OpenDKIM Filter v2.11.0 flint.cs.wisc.edu 21QJ3Lmo013624
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs.wisc.edu;
        s=csl-2018021300; t=1645902202;
        bh=pKGkqgL4RsButtUdsjPGYnTcZ6828o2Ovu8TngxsvzY=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=XbuRFqWzYy2eUGoGfy8s+I+vgzd6TouebUTzI9V36KZlRDpjJD/PrNl59lSYw00md
         QHETlRfbu0eCsVU5ZVPKEm/wx1RjOESiY8RxsJx3ltDZ4FMm09E9O0t1u9jHrwYbVm
         lQ1aUiNETYpgRNB6zK4NlBijc0nfHai+SqqtVwjxehTGlnq5AMKQCTqtvwgYWKqD1B
         71ts2tDLo/2Uv8tKpzMd2SYWOPpL7Krqbxbo5QyfOpSpQIqbxa9SOcXMlSKUZySnza
         v197aNLxqgw3FcECXhO0GaqJvVUaLjbI+xYkB6fAY7nWWd0h39TYS7SbaWQA7LC7nw
         aQ8Uc1kzZl5Yg==
Received: by mystras.cs.wisc.edu (Postfix, from userid 23719)
        id 470C6220A9D; Sat, 26 Feb 2022 13:03:21 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
        by mystras.cs.wisc.edu (Postfix) with ESMTP id 456E2220109;
        Sat, 26 Feb 2022 13:03:21 -0600 (CST)
Date:   Sat, 26 Feb 2022 13:03:21 -0600 (CST)
From:   Carl Edquist <edquist@cs.wisc.edu>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Thomas Renninger <trenn@suse.de>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: /proc/acpi/battery gone again, breaks wmpower
In-Reply-To: <20220225190522.cbqoxpsucvniep55@mercury.elektranox.org>
Message-ID: <bd028d74-aa7b-cfda-2ad2-77e3578d01e3@cs.wisc.edu>
References: <0718fe87-230f-b293-b998-b83f3c133367@cs.wisc.edu> <CAJZ5v0j=c-ctwqmRfvVtep4DtOf=6Gf=zs+B19aPDpQ0447oRw@mail.gmail.com> <CAJZ5v0h5D=1UWqmC=foAK3-p1LLV=KG8dRM-kPYxJc7GEKdZbQ@mail.gmail.com> <448277be-d848-d4dd-2d92-1b4e6ea69243@cs.wisc.edu>
 <20220225190522.cbqoxpsucvniep55@mercury.elektranox.org>
User-Agent: Alpine 2.25 (DEB 613 2021-11-14)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="1770006798-1279636274-1645899844=:682"
Content-ID: <53fa2080-9ba8-2058-aaae-cc54299b2e54@cs.wisc.edu>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1770006798-1279636274-1645899844=:682
Content-Type: text/plain; CHARSET=ISO-8859-15; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <6da537c4-3239-a8fb-cba8-2e2f1ae7ff6e@cs.wisc.edu>

Hi Sebastian!

On Fri, 25 Feb 2022, Sebastian Reichel wrote:

> On Thu, Feb 24, 2022 at 10:53:32AM -0600, Carl Edquist wrote:
>
>> I am happy to put in the legwork to get wmpower working using whatever=
=20
>> the blessed replacement is for the acpi procfs power stuff.  Maybe you=
=20
>> can help shed some light on the sysfs interface for me.
>
> FWIW the power-supply sysfs API exists since quite some time now
> (4a11b59d8283 from 2007), so it's not particularly new ;)

Sure, although .. it is new to me.  (I did not have a reason to care=20
before this month! :)  And I was having trouble finding any documentation=
=20
on certain details...  So your help is appreciated!


> ... the power-supply subsystem passes through the data provided by the=20
> hardware without unit conversion. So one of the battery fuel gauges in=20
> your laptops provides its numbers in Wh and one provides it in Ah. In=20
> (non ACPI) embedded systems you might also get neither of them.

Again I seem to be losing my mind, since now both of my laptops show=20
energy_now & power_now.  Is it possibly that a single battery might=20
sometimes come up showing Wh and sometimes Ah ?


> The units for the sysfs files are fixed, so a system reporting Ah=20
> provides current_now/charge_now files and Wh based systems provide=20
> power_now/energy_now files.

Ok, so if I understand you right, if the /proc/acpi/battery/BATX/state=20
shows "present rate" and "remaining capacity", then I should always be=20
able to find the sysfs equivalents for that battery under=20
current_now/charge_now or power_now/energy_now.


>> I guess the convenient thing about the /proc/acpi/battery interfaces is=
=20
>> that it automatically presents the right info for rate & capacity.

By the way, what I meant here is that it was handy in the procfs interface=
=20
to be able to look up a single value (eg "remaining capacity"), and that=20
always provide you with the number you cared about, rather than have to=20
try looking up two separate values (charge_now or energy_now) to see which=
=20
one exists.  As far as I can tell there is nothing in the sysfs equivalent=
=20
even telling you which attribute to check, other than trying both and=20
failing over as necessary.  (Eg, there is not something like a=20
"capacity_type" attribute to tell you whether a battery reports "energy"=20
or "charge" ...)

> The files in /sys/class/power_supply always report almost all values in=
=20
> =B5 units (i.e. =B5A, =B5V, =B5Ah, =B5W, ...), one value per file and wit=
h fixed=20
> units. Documentation can be found here:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/ABI/testing/sysfs-class-power

I kind of found the documentation there lacking, from an end user=20
perspective.  For one, it does not seem to mention anywhere the existence=
=20
of the power_now/energy_now files, so it was only by chance that I=20
happened to stumble on their existence on one of my laptops.  For another=
=20
thing, not all the attributes in that document necessarily appear to be=20
present.  Eg, "current_avg" does not appear for my battery when=20
current_now does.  (Nor "power_avg", which is not documented, but=20
presumably should exist as a "current_avg" analog when power_now is=20
present?)

Anyway point being it really was not clear from the outside which=20
attributes are reliably available, and thus what the general method is for=
=20
something as simple as determining time-to-empty and time-to-full for=20
batteries.  (To replace what used to work in /proc/acpi/battery, that is.)


>> I'm also curious, is the "BAT[0-*]" pattern for battery names=20
>> consistent, or are there other possibilities?  [...]
>
> The subsystem does not have any name constraints. But you can find the=20
> device type via the 'type' file and non-system level devices (e.g.=20
> battery of a game controller) set the 'scope' property to "Device".

Oh wow.  I hadn't thought of game controller batteries.  I have no idea=20
what it means to set the 'scope' property though :)

>> I'm also thinking to enumerate batteries & AC power supplies via=20
>> /sys/bus/acpi/drivers/{ac,battery} rather than /sys/class/power_supply,=
=20
>> as surprisingly even a USB-C stick can show up under power_supply, and=
=20
>> it's not obvious if there's a clean way to sort out what's what then.
>
> USB-C is kind of tricky with the option to reverse power-flow in many=20
> cases (e.g. laptop can charge a power bank or power bank can charge a=20
> laptop using the same connector). In general you definetly can get=20
> non-ACPI power-supply devices, e.g. batteries from wireless keyboards.

That is wild (interesting!), but I think in this case I'm only interested=
=20
in the main battery sources.

> Also some devices have broken ACPI battery handling, so the ACPI driver=
=20
> is blacklisted and native hardware drivers are used instead. In that=20
> case you will not find anything power related in /sys/bus/acpi.

Ok.  So I think as long as it was something that used to report under=20
/proc/acpi/battery (which I think is the scope I care about here), it=20
should report under /sys/bus/acpi/drivers/battery, right?

Thanks for all the help!

Carl
--1770006798-1279636274-1645899844=:682--
