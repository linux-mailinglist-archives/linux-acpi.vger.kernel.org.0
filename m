Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 818664C34E6
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Feb 2022 19:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbiBXSmn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 24 Feb 2022 13:42:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbiBXSmk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Feb 2022 13:42:40 -0500
X-Greylist: delayed 3601 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 24 Feb 2022 10:42:09 PST
Received: from smtpout2.cs.wisc.edu (smtpout2.cs.wisc.edu [128.105.6.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CBB21B71BB;
        Thu, 24 Feb 2022 10:42:08 -0800 (PST)
Received: from mystras.cs.wisc.edu (mystras.cs.wisc.edu [128.105.14.41])
        by flint.cs.wisc.edu (8.14.7/8.14.4) with ESMTP id 21OGrWaX019609;
        Thu, 24 Feb 2022 10:53:33 -0600
DKIM-Filter: OpenDKIM Filter v2.11.0 flint.cs.wisc.edu 21OGrWaX019609
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs.wisc.edu;
        s=csl-2018021300; t=1645721613;
        bh=5+Rhc5u95YZwEOYeX3cMkQ0VK4mZuVJcjFw0CDnt7go=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=2m7XVuJf2FoMLAhBDBV1TD2tP+BK/CNKe4bHjUg0/ME8oXQ8xRFAgvvpZteFeUoxb
         NhjXOk2rBFuDgU4eVlG03aUJJrwOXEzA+SS60p88AJYAtwUaW5aSt/YzkK2VKuxR7x
         RRFgCQPYABmuYndQFNG1qIbGbwlXXKfeynZ31c+4J09Y7Aku2O5X4UnrcP2Z+glI1f
         bA1ERUldjKqGj8QoY0lLk+ierB7SCR92EjryMWhgnPz7lEhBw1u3X8tMX2Mrw6X5Ri
         2o3wUJ3SGeZZRf7ApG2Dc1IRhH8ofFitvM/xgR7MLKYM4R3VXEAML1WIzGwvwOuONV
         3djLW/VvHS0EA==
Received: by mystras.cs.wisc.edu (Postfix, from userid 23719)
        id E0DA022051D; Thu, 24 Feb 2022 10:53:32 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
        by mystras.cs.wisc.edu (Postfix) with ESMTP id DF53C22041D;
        Thu, 24 Feb 2022 10:53:32 -0600 (CST)
Date:   Thu, 24 Feb 2022 10:53:32 -0600 (CST)
From:   Carl Edquist <edquist@cs.wisc.edu>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
cc:     Thomas Renninger <trenn@suse.de>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: /proc/acpi/battery gone again, breaks wmpower
In-Reply-To: <CAJZ5v0h5D=1UWqmC=foAK3-p1LLV=KG8dRM-kPYxJc7GEKdZbQ@mail.gmail.com>
Message-ID: <448277be-d848-d4dd-2d92-1b4e6ea69243@cs.wisc.edu>
References: <0718fe87-230f-b293-b998-b83f3c133367@cs.wisc.edu> <CAJZ5v0j=c-ctwqmRfvVtep4DtOf=6Gf=zs+B19aPDpQ0447oRw@mail.gmail.com> <CAJZ5v0h5D=1UWqmC=foAK3-p1LLV=KG8dRM-kPYxJc7GEKdZbQ@mail.gmail.com>
User-Agent: Alpine 2.25 (DEB 613 2021-11-14)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="1770006798-1776269239-1645632574=:4849"
Content-ID: <32ec22c4-30aa-1533-b70c-23a43703ae5d@cs.wisc.edu>
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

--1770006798-1776269239-1645632574=:4849
Content-Type: text/plain; CHARSET=US-ASCII; format=flowed
Content-ID: <8ec38686-1c32-f533-b5ac-1f16909d92c2@cs.wisc.edu>

Hi Rafael, thanks for the follow-up!

On Mon, 21 Feb 2022, Rafael J. Wysocki wrote:

>> Because we promise that user space won't be broken by kernel changes, 
>> it needs to be restored to make wmpower work again.
>>
>> I'd rather not restore all of it, though, just the part relied on by 
>> wmpower.
>
> Please check if the attached patch (on top of 5.17-rc5) is sufficient to 
> restore the wmpower functionality.

When I try to build (v5.17-rc5 + patch) with gcc 11.2.0, I get what looks 
to be a syntax error in ac.c:

drivers/acpi/ac.c: In function 'acpi_ac_add_fs':
drivers/acpi/ac.c:182:29: error: expected ')' before 'PREFIX'
   182 |         printk(KERN_WARNING PREFIX "Deprecated procfs I/F for AC is loaded,"

I've attached an error.log; if you'd like I can send along my .config 
also.

...

My thoughts about this though -

I did not really expect to get this interface back after I read the commit 
message for its removal.  I admire your fidelity to the linux user 
promise, but I don't want to create trouble for you guys either.

I am happy to put in the legwork to get wmpower working using whatever the 
blessed replacement is for the acpi procfs power stuff.  Maybe you can 
help shed some light on the sysfs interface for me.

I started exploring a bit under /sys/class/power_supply, looking for 
replacements for the "present rate" and "last full/remaining capacity" 
items under /proc/acpi/battery.  Curiously I have two lenovo ThinkPads, a 
T510 and a T540p, and one of them has current_now & charge_full/_now, and 
the other has power_now & energy_full/_now.  Are these the only two 
possibilities for rate & capacity?  Or are there other potentially others?

I guess the convenient thing about the /proc/acpi/battery interfaces is 
that it automatically presents the right info for rate & capacity.

(I felt like I was losing my mind for a bit when I saw the units presented 
as "mAh" in one after I was sure I had read "mWh" before... But reading 
your patch helped give me a better clue about what was going on there.)

I'm also curious, is the "BAT[0-*]" pattern for battery names consistent, 
or are there other possibilities?  I had suspected "AC" was the standard 
power_supply name for the main AC power, but that turned out not to be the 
case on another (HP) laptop that I took a look at.  Which leads me to 
suspect that "BATX" is not necessarily standard either.

I'm also thinking to enumerate batteries & AC power supplies via 
/sys/bus/acpi/drivers/{ac,battery} rather than /sys/class/power_supply, as 
surprisingly even a USB-C stick can show up under power_supply, and it's 
not obvious if there's a clean way to sort out what's what then.

...

I say all this of course as a laptop end-user, and even with the kernel 
source docs in front of me I seem to be feeling my way around in the dark. 
I don't know much about the linux acpi internals, and I did not learn 
about the acpi procfs power interface being deprecated until after wmpower 
stopped working for me this month :)

It seems like part of the difficulty is that there is not much of a 
feedback loop for end users to realize that they are using deprecated 
procfs interfaces, whether directly in custom battery scripts that scrape 
/proc/acpi/battery, or unwittingly through other programs they happen to 
use (in this case wmpower).  There are no warnings until it's too late.

And even taking a look at what happened the first time it was removed [1], 
it seems the conclusion was "some people are still using programs that 
rely on the interface, so we'll add it back" ... But it's not obvious if 
any effort was made to contact maintainers with a little nudge, to let 
them know that it's (still) deprecated and what the replacement interface 
is.

Not sure what the general solution is there, but in any case I'll 
cheerfully fix up wmpower.


Thanks again and sorry for the long mail :)

Carl


[1] https://lkml.org/lkml/2014/4/21/152
--1770006798-1776269239-1645632574=:4849
Content-Type: text/plain; CHARSET=US-ASCII; NAME=error.log
Content-Transfer-Encoding: BASE64
Content-ID: <030df7f0-ed2a-e00a-268b-1429f759ab6f@cs.wisc.edu>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME=error.log

ICBDQyBbTV0gIGRyaXZlcnMvYWNwaS9hYy5vDQpJbiBmaWxlIGluY2x1ZGVk
IGZyb20gLi9pbmNsdWRlL2xpbnV4L2tlcm5lbC5oOjI5LA0KICAgICAgICAg
ICAgICAgICBmcm9tIGRyaXZlcnMvYWNwaS9hYy5jOjExOg0KZHJpdmVycy9h
Y3BpL2FjLmM6IEluIGZ1bmN0aW9uICdhY3BpX2FjX2FkZF9mcyc6DQpkcml2
ZXJzL2FjcGkvYWMuYzoxODI6Mjk6IGVycm9yOiBleHBlY3RlZCAnKScgYmVm
b3JlICdQUkVGSVgnDQogIDE4MiB8ICAgICAgICAgcHJpbnRrKEtFUk5fV0FS
TklORyBQUkVGSVggIkRlcHJlY2F0ZWQgcHJvY2ZzIEkvRiBmb3IgQUMgaXMg
bG9hZGVkLCINCiAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IF5+fn5+fg0KLi9pbmNsdWRlL2xpbnV4L3ByaW50ay5oOjQxODoyNTogbm90
ZTogaW4gZGVmaW5pdGlvbiBvZiBtYWNybyAncHJpbnRrX2luZGV4X3dyYScN
CiAgNDE4IHwgICAgICAgICAgICAgICAgIF9wX2Z1bmMoX2ZtdCwgIyNfX1ZB
X0FSR1NfXyk7ICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0KICAgICAg
fCAgICAgICAgICAgICAgICAgICAgICAgICBefn5+DQpkcml2ZXJzL2FjcGkv
YWMuYzoxODI6OTogbm90ZTogaW4gZXhwYW5zaW9uIG9mIG1hY3JvICdwcmlu
dGsnDQogIDE4MiB8ICAgICAgICAgcHJpbnRrKEtFUk5fV0FSTklORyBQUkVG
SVggIkRlcHJlY2F0ZWQgcHJvY2ZzIEkvRiBmb3IgQUMgaXMgbG9hZGVkLCIN
CiAgICAgIHwgICAgICAgICBefn5+fn4NCi4vaW5jbHVkZS9saW51eC9wcmlu
dGsuaDo0MTg6MjQ6IG5vdGU6IHRvIG1hdGNoIHRoaXMgJygnDQogIDQxOCB8
ICAgICAgICAgICAgICAgICBfcF9mdW5jKF9mbXQsICMjX19WQV9BUkdTX18p
OyAgICAgICAgICAgICAgICAgICAgICAgICAgIFwNCiAgICAgIHwgICAgICAg
ICAgICAgICAgICAgICAgICBeDQouL2luY2x1ZGUvbGludXgvcHJpbnRrLmg6
NDQ2OjI2OiBub3RlOiBpbiBleHBhbnNpb24gb2YgbWFjcm8gJ3ByaW50a19p
bmRleF93cmFwJw0KICA0NDYgfCAjZGVmaW5lIHByaW50ayhmbXQsIC4uLikg
cHJpbnRrX2luZGV4X3dyYXAoX3ByaW50aywgZm10LCAjI19fVkFfQVJHU19f
KQ0KICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgXn5+fn5+fn5+
fn5+fn5+fn4NCmRyaXZlcnMvYWNwaS9hYy5jOjE4Mjo5OiBub3RlOiBpbiBl
eHBhbnNpb24gb2YgbWFjcm8gJ3ByaW50aycNCiAgMTgyIHwgICAgICAgICBw
cmludGsoS0VSTl9XQVJOSU5HIFBSRUZJWCAiRGVwcmVjYXRlZCBwcm9jZnMg
SS9GIGZvciBBQyBpcyBsb2FkZWQsIg0KICAgICAgfCAgICAgICAgIF5+fn5+
fg0K

--1770006798-1776269239-1645632574=:4849--
