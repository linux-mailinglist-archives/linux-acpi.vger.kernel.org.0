Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9EA2F2D1B
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Jan 2021 11:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727725AbhALKnw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 12 Jan 2021 05:43:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55512 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727711AbhALKnw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 12 Jan 2021 05:43:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610448145;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3oNdvQC+Ac+sooybQJvFa4jEanbWZLFkjC2sBkbCnHM=;
        b=FR3lpSdNKi4SX/Y+O7efPHMN5EGVzu9AtusIvebWVSptC15cDpZMUTKSG8L6gVDU+Sqogi
        3gueUcrmi/8vgaLL85h/Czpn2OYtXcaaLWqPFwY441jrKPMY8aSZoeLSBe5lI+gJd/fZL0
        zKqtU9Q0550bPFpcT/ykF3YOTVoAgos=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-CgSo5o92MGOA2niEKX4Heg-1; Tue, 12 Jan 2021 05:42:12 -0500
X-MC-Unique: CgSo5o92MGOA2niEKX4Heg-1
Received: by mail-ed1-f70.google.com with SMTP id u17so805452edi.18
        for <linux-acpi@vger.kernel.org>; Tue, 12 Jan 2021 02:42:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3oNdvQC+Ac+sooybQJvFa4jEanbWZLFkjC2sBkbCnHM=;
        b=T8W1ySlHzPw8k3Oa7RWSiYXeY9uXLtPlA4kRT4SLdIB65oM9ZPcD6m6PgEqdpm2geP
         nN83Zq05fdBY5PKdKC4DK8r0XzOchW0wrFtPCgbhY0z266B7cUIgDX8nJARL7vnG2ziL
         Y27t3j2wP8ZhMYQlRlB6IjleLizVYYlhJGSORjFoGvsqlCVVG2v+/XE8qm1SUEuAcy6g
         Trx4eM2yyKDCWVjIRiGt25gZyWOCctkrGjkRLAXlYHF/yDjHDvX/1ZhvzcfXr9O471+z
         7jPBnZycI0K6WSUorKlI1b0WYW3r5yesjbyKebJCrDZaTPiqMabBPVu6xqd1ZSxpoNq/
         wcnQ==
X-Gm-Message-State: AOAM530Bh+5K8I7W/p+9emNeo3eD/J4nGSldBD+KLKPr9jz3t9wL5gdk
        9bT5zAwECNa1sfu6wSAnFFrr0xTyCAx/1bjWhk5b2lq1YmvXDodmT9pNYoiyg/Qxwk+HWcXAoUS
        CDtp2YXrmtVgjb6NXZRl0ig==
X-Received: by 2002:a50:8b02:: with SMTP id l2mr2798212edl.322.1610448129268;
        Tue, 12 Jan 2021 02:42:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyikftM4Q6LhoYQoL6TgsB2gVtNMetBII9AVQx5KVaUsTOlS+OXwbXMi9PZti/IJFZnSAXYIA==
X-Received: by 2002:a50:8b02:: with SMTP id l2mr2798200edl.322.1610448129094;
        Tue, 12 Jan 2021 02:42:09 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id j23sm261937ejs.112.2021.01.12.02.42.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jan 2021 02:42:08 -0800 (PST)
Subject: Re: [pm:bleeding-edge 20/29] drivers/acpi/platform_profile.c:67:33:
 error: passing 'const struct platform_profile_handler to parameter of type
 'struct platform_profile_handler discards qualifiers
To:     kernel test robot <lkp@intel.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
References: <202101081623.CGkLO3Kx-lkp@intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <5e7a4d87-52ef-e487-9cc2-8e7094beaa08@redhat.com>
Date:   Tue, 12 Jan 2021 11:42:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <202101081623.CGkLO3Kx-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 1/8/21 9:52 AM, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
> head:   2691096b51bae3563007c4b0188c3eec9878224b
> commit: b417d9c7404df67b9be0104585fefb2ca8d36677 [20/29] ACPI: platform-profile: Pass profile pointer to driver callbacks
> config: x86_64-randconfig-r011-20210108 (attached as .config)
> compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project 5c951623bc8965fa1e89660f2f5f4a2944e4981a)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install x86_64 cross compiling tool for clang build
>         # apt-get install binutils-x86-64-linux-gnu
>         # https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?id=b417d9c7404df67b9be0104585fefb2ca8d36677
>         git remote add pm https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
>         git fetch --no-tags pm bleeding-edge
>         git checkout b417d9c7404df67b9be0104585fefb2ca8d36677
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>>> drivers/acpi/platform_profile.c:67:33: error: passing 'const struct platform_profile_handler *' to parameter of type 'struct platform_profile_handler *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
>            err = cur_profile->profile_get(cur_profile, &profile);
>                                           ^~~~~~~~~~~
>    drivers/acpi/platform_profile.c:107:33: error: passing 'const struct platform_profile_handler *' to parameter of type 'struct platform_profile_handler *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
>            err = cur_profile->profile_set(cur_profile, i);
>                                           ^~~~~~~~~~~
>    2 errors generated.

Ugh, so that means that the current version of the
"ACPI: platform-profile: Pass profile pointer to driver callbacks"
patch is no good. Since this is causing compile errors I assume
that it will be dropped from the bleeding-edge branch.
Is that right Rafael?

I believe that the best fix is to just drop the const everywhere,
neither of the 2 planned uses has its platform_profile_handler defined
as const:

1. In the thinkpad_acpi case it is not const, because of using set_bit
calls to set the choices bits.

2. In the ideapad-laptop case it is not const because it will be
embedded in the dynamically allocated drv_data struct.

Jiaxun, can you do a new version where you drop the const (and
explain why this is done in the commit message)  ?

Regards,

Hans




> 
> 
> vim +67 drivers/acpi/platform_profile.c
> 
>     50	
>     51	static ssize_t platform_profile_show(struct device *dev,
>     52						struct device_attribute *attr,
>     53						char *buf)
>     54	{
>     55		enum platform_profile_option profile = PLATFORM_PROFILE_BALANCED;
>     56		int err;
>     57	
>     58		err = mutex_lock_interruptible(&profile_lock);
>     59		if (err)
>     60			return err;
>     61	
>     62		if (!cur_profile) {
>     63			mutex_unlock(&profile_lock);
>     64			return -ENODEV;
>     65		}
>     66	
>   > 67		err = cur_profile->profile_get(cur_profile, &profile);
>     68		mutex_unlock(&profile_lock);
>     69		if (err)
>     70			return err;
>     71	
>     72		/* Check that profile is valid index */
>     73		if (WARN_ON((profile < 0) || (profile >= ARRAY_SIZE(profile_names))))
>     74			return -EIO;
>     75	
>     76		return sysfs_emit(buf, "%s\n", profile_names[profile]);
>     77	}
>     78	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 

