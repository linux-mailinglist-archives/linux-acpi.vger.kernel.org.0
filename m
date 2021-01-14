Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B54992F6F01
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Jan 2021 00:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731031AbhANXgS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 14 Jan 2021 18:36:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29206 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730570AbhANXgS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 14 Jan 2021 18:36:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610667291;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PfasKP2iCnaJb0ZdoB0GjmrRdn+LyX4XBde4LYRSHHM=;
        b=H1JIV/lxYSPYjp2SsAmU1Ni6Ba6bYmnhz4PxHa7Qbg3SMydj/C9VsDABVtjH3AVNw6m0nu
        uPw5GXMqfpdd8CrKy2LPxUFJ58WZRvDkELfBzWvSLTU810cLIIzshJnMG8O1uqotgwbZMa
        lD0N+aHQjhhzA/ZGr1ZMGoICU3amo2c=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-450-OiXrnLZPPgOen2LqcpHWdg-1; Thu, 14 Jan 2021 18:34:50 -0500
X-MC-Unique: OiXrnLZPPgOen2LqcpHWdg-1
Received: by mail-ed1-f72.google.com with SMTP id k5so3019638edk.15
        for <linux-acpi@vger.kernel.org>; Thu, 14 Jan 2021 15:34:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PfasKP2iCnaJb0ZdoB0GjmrRdn+LyX4XBde4LYRSHHM=;
        b=Qp8Ic46lsnsqSjlI96DIwNxAvmrAuusa8k3jUM2n+KHXMOe0jGxJ1hRlmqDGT4nB80
         J3y4StHxflH7lvFQlXpnty15VXzeU/BWR4GzwSzNB2/bdrkA9S7ySFNaGOkY5Txhjuo6
         +IzlbA2DcqZ2MvRy70OD1nQk/twTMD4IpBO7aUhkXMEZREXDfD36WBiclzDnPfQJxnVs
         j+EuIzCJd35tRFqZ8LGWqbxqT3tWfJ3VmAOy2oyN+FEx7p0iVbpPmqNQGcJzrc+gKc50
         CxJiZijV1D5fDNPc81cgCUkZ8reUr/82GrnfjDdpa6sZ6Pf6an1MJcCTamd+09MLAxc8
         1edg==
X-Gm-Message-State: AOAM530yolreWBHtF0ji3UkM0bETt4RaH/TeTxnXTF+b6njPSDlItpsf
        bWm6fEPali+rYlBTKSCVv9XBDRM+fBNrh89kKcURovxCWWLYSduIcWE/692PwdQV/al5sNcaoio
        107p37iZvsjeNuXx+AKim8Q==
X-Received: by 2002:a17:906:7118:: with SMTP id x24mr6918828ejj.333.1610667288412;
        Thu, 14 Jan 2021 15:34:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxmQdg7NIsXTOozpD4hbk20BGP4x/85hzBaKHv5Vm7Le7k9XeOGmeKmByvt8xPeOcbg1SICRw==
X-Received: by 2002:a17:906:7118:: with SMTP id x24mr6918814ejj.333.1610667288217;
        Thu, 14 Jan 2021 15:34:48 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id w11sm800746edj.8.2021.01.14.15.34.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jan 2021 15:34:47 -0800 (PST)
Subject: Re: ACPI scan regression -> Boot fail on Cherrytrail w/ 5.11-rc3
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        ACPI Devel Mailing List <linux-acpi@vger.kernel.org>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <792c89fd-88f2-b243-50df-21f3be1cc20c@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <f5dae2aa-ffcb-1af1-726f-2362cb4fe470@redhat.com>
Date:   Fri, 15 Jan 2021 00:34:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <792c89fd-88f2-b243-50df-21f3be1cc20c@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 1/14/21 10:55 PM, Pierre-Louis Bossart wrote:
> Hi,
> My primary test device for SOF on Cherrytrail no longer boots with v5.11-rc3 and the sof-dev branch, nothing happens after the 'loading initial ramdisk'. It's a 'Zotac' headless device derived from the Cherrytrail FFD design, so likely there are other devices hit by this problem.
> 
> A long bisect points to the commit 71da201f38dfb ('ACPI: scan: Defer enumeration of devices with _DEP lists').
> 
> Reverting the two commits below solves the boot issue.
> 
> I have absolutely no idea what these two patches do, but they sure have a large impact. Please let me know what sort of information or tests might help root-cause this problem.

Heh, I was just about to answer your other (off-list) email about your
CHT test device booting with a suggestion that you should try reverting that
exact commit as it is the only commit that I'm aware of which went into 5.11
which might cause this...

So I just boot 5.11-rc3 on a Acer Aspire Switch 10E SW3-016 (x5-Z8300 CHT
based) myself and that booted fine.`

Next I tried a MINIX NEO Z83-4 (x5-Z8300) which is a Mini PC and as such
probably the closest to the Zotac box which you are using which I have
at hand to test on, and I can somewhat reproduce it there.

It seems that the new code somehow causes us to hit a race somewhere, so
the NEO Z83-4 will boot most of the times but not always, it get past
the loading initrd phase for me and then it threw the following error
and after that the boot hung (waiting for the rootfs to show up)

platform device 80860F14: Resources present before probing

As I already told Rafael in a previous email, I did see something
similar when my personal tree was still 5.10 based, with the ACPI
scan rework patches cherry-picked for testing. In that case I got
a backtrace (followed by a hang) during boot about a kernel NULL
pointer deref triggered by sysfs_seq_file_read or some such. But
this problem went away with 5.11-rc1, so I stopped looking into
it. I do have a tag of my broken 5.10 + cherry-picks tree, so
I should be able to reproduce that issue.

So I see 2 possible theories here:

1. We have 2 probes of the same device racing somehow
2. The struct device memory is getting corrupted somehow.

Pierre-Louis, can you see if the following hack helps? :

--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1939,7 +1939,6 @@ static acpi_status acpi_bus_check_add(acpi_handle handle, bool check_dep,
 		/* Bail out if the number of recorded dependencies is not 0. */
 		if (count > 0) {
 			acpi_bus_scan_second_pass = true;
-			return AE_CTRL_DEPTH;
 		}
 	}
 
@@ -1948,8 +1947,7 @@ static acpi_status acpi_bus_check_add(acpi_handle handle, bool check_dep,
 		return AE_CTRL_DEPTH;
 
 	acpi_scan_init_hotplug(device);
-	if (!check_dep)
-		acpi_scan_dep_init(device);
+	acpi_scan_dep_init(device);
 
 out:
 	if (!*adev_p)

And can you collect an acpidump from the device and either send it to me and Rafael
offlist, or upload it somewhere and send us a link ?

Regards,

Hans

