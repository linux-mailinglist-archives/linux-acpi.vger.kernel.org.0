Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C169C2E30FF
	for <lists+linux-acpi@lfdr.de>; Sun, 27 Dec 2020 12:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbgL0L57 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 27 Dec 2020 06:57:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32087 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726039AbgL0L57 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 27 Dec 2020 06:57:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609070192;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9ys+IfJQ4jaDgELByvREU1Pf0LqPPJ8r6KX3wnASlGk=;
        b=eMFVcR4AAG6W+FtPvmCBM20TktWf4P0v4atKQlnfGG3XAFUS2/eTEBnB9OZQb7LXa9QtBq
        YiM+l6J5KFTe+HdJktCG12OwFvgpIzqcTSWk1ToeEit4cWFsXyAgke/EbqmFwRhdaJR1VP
        5zD/yjCAzje/iPUMbLPKmoFejtXTCos=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-ET6CTTcrPHSEDe_mdsbHOA-1; Sun, 27 Dec 2020 06:56:25 -0500
X-MC-Unique: ET6CTTcrPHSEDe_mdsbHOA-1
Received: by mail-ej1-f71.google.com with SMTP id h4so1846569eja.12
        for <linux-acpi@vger.kernel.org>; Sun, 27 Dec 2020 03:56:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9ys+IfJQ4jaDgELByvREU1Pf0LqPPJ8r6KX3wnASlGk=;
        b=gPfTesNlyPCiBJZlwXAebX7hi9iJRTuugdgjaercy7Trz8PJA7vskkEeNyVzoDRdad
         zyhL0OMGZs26phkh5K/D4RB/l6NEHEpqstFM5iCPLk5i6dlcKrqDUoFkdyE4shyOXCVq
         YMP2qlDRkP2YySJIs/lEBaG6Qs7lPNlbAC0BP/u42Lqrv0eKB4MI/XwiXFcAjx8e1ndV
         iWPRBNQnESdqllTYb2NpQGECxde0asPP3fTuiX7crmXq79VmNPGwN343UWeTzHRGv3Oz
         g5acQH9pjPnr03JSiGN48gP1gNGW/+y7A1OmuWmwxm1tVHQP7K3w9vDttxUW3hUq6xtX
         posw==
X-Gm-Message-State: AOAM5304vSzKTG3wd5jyG+F+C6h05b15L1fRmAnQR6nCa8M082ejo4U3
        Wiv+0I4mhORqMbeYfmr1kreMPILTjR0aSuhoPf4DH2H3u5ZsD8JN5w8tEu5lN9a8lZFJjcKmo8h
        kV03K4FZ35dCI3Fo3aaNb0Q==
X-Received: by 2002:a17:906:710b:: with SMTP id x11mr39696679ejj.433.1609070183351;
        Sun, 27 Dec 2020 03:56:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwnc5Um/4mkKSiag3jZlEv6fWKGuXg9vVpDEurV5CS3KXc+TJKo9Vs2YkS+2syQUvzKwp7z8A==
X-Received: by 2002:a17:906:710b:: with SMTP id x11mr39696662ejj.433.1609070183123;
        Sun, 27 Dec 2020 03:56:23 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id w17sm34409942edu.90.2020.12.27.03.56.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Dec 2020 03:56:22 -0800 (PST)
Subject: Re: [pm:bleeding-edge 8612/8615]
 drivers/acpi/platform_profile.c:147:24: warning: address of array
 'pprof->choices' will always evaluate to 'true'
To:     kernel test robot <lkp@intel.com>,
        Mark Pearson <markpearson@lenovo.com>
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
References: <202012271352.JvNDF17O-lkp@intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <34a43212-ff2b-cbc6-a670-975d39ac9f12@redhat.com>
Date:   Sun, 27 Dec 2020 12:56:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <202012271352.JvNDF17O-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 12/27/20 6:11 AM, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
> head:   a33520709645543f108361fe21fa9434a351c4e9
> commit: 8c9b909fb1282e43792433e6c1cba125ccfc6201 [8612/8615] ACPI: platform-profile: Add platform profile support
> config: x86_64-randconfig-a015-20201221 (attached as .config)
> compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project cee1e7d14f4628d6174b33640d502bff3b54ae45)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install x86_64 cross compiling tool for clang build
>         # apt-get install binutils-x86-64-linux-gnu
>         # https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?id=8c9b909fb1282e43792433e6c1cba125ccfc6201
>         git remote add pm https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
>         git fetch --no-tags pm bleeding-edge
>         git checkout 8c9b909fb1282e43792433e6c1cba125ccfc6201
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>>> drivers/acpi/platform_profile.c:147:24: warning: address of array 'pprof->choices' will always evaluate to 'true' [-Wpointer-bool-conversion]
>            if (!pprof || !pprof->choices || !pprof->profile_set ||
>                          ~~~~~~~~^~~~~~~
>    1 warning generated.


Ah, this is caused by changing choices from a single long to:

	unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];

So that we can use for_each_set_bit and are future proof for more then
32 profiles.

To fix this the check should be changed into this (untested):

#include <linux/bitmap.h>

	if (!pprof || bitmap_empty(pprof->choices, PLATFORM_PROFILE_LAST) ||
	    !pprof->profile_set || !pprof->profile_get) {
		mutex_unlock(&profile_lock);
		return -EINVAL;
	}

Mark can you provide a (tested) patch for this?

Regards,

Hans








> 
> 
> vim +147 drivers/acpi/platform_profile.c
> 
>    134	
>    135	int platform_profile_register(const struct platform_profile_handler *pprof)
>    136	{
>    137		int err;
>    138	
>    139		mutex_lock(&profile_lock);
>    140		/* We can only have one active profile */
>    141		if (cur_profile) {
>    142			mutex_unlock(&profile_lock);
>    143			return -EEXIST;
>    144		}
>    145	
>    146		/* Sanity check the profile handler field are set */
>  > 147		if (!pprof || !pprof->choices || !pprof->profile_set ||
>    148				!pprof->profile_get) {
>    149			mutex_unlock(&profile_lock);
>    150			return -EINVAL;
>    151		}
>    152	
>    153		err = sysfs_create_group(acpi_kobj, &platform_profile_group);
>    154		if (err) {
>    155			mutex_unlock(&profile_lock);
>    156			return err;
>    157		}
>    158	
>    159		cur_profile = pprof;
>    160		mutex_unlock(&profile_lock);
>    161		return 0;
>    162	}
>    163	EXPORT_SYMBOL_GPL(platform_profile_register);
>    164	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 

