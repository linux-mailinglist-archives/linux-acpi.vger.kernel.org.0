Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA081EC593
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Jun 2020 01:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgFBXV4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 2 Jun 2020 19:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbgFBXVz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Jun 2020 19:21:55 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81EFC08C5C2
        for <linux-acpi@vger.kernel.org>; Tue,  2 Jun 2020 16:21:55 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id v2so234073pfv.7
        for <linux-acpi@vger.kernel.org>; Tue, 02 Jun 2020 16:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version;
        bh=j/bXtx1ddGk4H0KvvoSDSpxGdkY1P8Eod8Yg0vO1Kqo=;
        b=w4nUPI4w3pGCIY6LYrvZwYN6HMlssQ0exyUU5L/VtL4SK+TfkinMUW7jdTEIN9ONv9
         fvw4zaDg5BSNYFms2nCG0N4pzb3OppLz3HkGwVjcB0AyHE0v/tHLZLzwtzIrtshJdzHW
         fuBKo+S4+EwlT8nZ6/+K69gLI9qeU1G4CyCdQZ/loOK4xObKand4FO7f/lqMGFWYLbsd
         9VbC3NJA2Il0a3A3IDnmsuapNR/lxkqrzSMSyXKdxqrMTNkfzgA89dOc5e9b0bY53a/j
         u8Pv3yP+vZrsIf8NdAt1jH32ELTuwpVycVaKgYoBAFg2NW/HyX787dnh7YTAVUDYrjkX
         NEqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version;
        bh=j/bXtx1ddGk4H0KvvoSDSpxGdkY1P8Eod8Yg0vO1Kqo=;
        b=Hk5cIFRcqaBSifXamRPiv4jb5tWTQmg9e+HrrRmmUDnOHh3zHTPxB83uItbxU68hph
         BcZpPsM5FOo2eYW9iu7JEoF3HunzE7amR+H0iMXZj2lO3UOwvtssluCPswT/WqLm+Rkx
         O4nB5Fsaaw1I33+M4gYW4UCsbnQwa94px1U1+cB6gjV1tNgE86K4Wk+ea1zfFdsrMos3
         ZoLAEYiEWVZvZx8ZBBnQWRp7Zf796n109zgdlZAN7LGjyF9Iz54t766R6EV9VAeDVctU
         m6wIf0E66G2pEgVKkYUYinznvTbm+XjFEZ9yqMq1OSJnHQxSIOlgra9851faWbdKEdAd
         I+gA==
X-Gm-Message-State: AOAM531uWKq4Jjw4r1OJAZpjdrUOirehfoUDZW0t99n8i9FHfNIOjnNh
        VbuonuwAAq70cjv14ltufUljUw==
X-Google-Smtp-Source: ABdhPJyB+vOXc6RyJKfkAUj9R8KIam1cWPMbqP0qCHGRNhjMYLLPjcZGbsicqAlsqPPqEmuCC7Yciw==
X-Received: by 2002:a05:6a00:1511:: with SMTP id q17mr20941279pfu.16.1591140115299;
        Tue, 02 Jun 2020 16:21:55 -0700 (PDT)
Received: from [10.212.71.40] ([192.55.54.40])
        by smtp.gmail.com with ESMTPSA id w128sm180690pfb.124.2020.06.02.16.21.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jun 2020 16:21:54 -0700 (PDT)
From:   "Sean V Kelley" <sean.v.kelley@intel.com>
To:     "Bjorn Helgaas" <helgaas@kernel.org>
Cc:     "Sinan Kaya" <okaya@kernel.org>,
        "Yicong Yang" <yangyicong@hisilicon.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Linux PCI" <linux-pci@vger.kernel.org>,
        "ACPI Devel Maling List" <linux-acpi@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH] PCI/ASPM: Print correct ASPM status when _OSC failed
Date:   Tue, 02 Jun 2020 16:21:51 -0700
X-Mailer: MailMate (1.13.1r5671)
Message-ID: <B2282A82-EEA4-40F8-B7F5-1D7AE7E3B573@intel.com>
In-Reply-To: <20200602223618.GA845676@bjorn-Precision-5520>
References: <20200602223618.GA845676@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2 Jun 2020, at 15:36, Bjorn Helgaas wrote:

> On Tue, Jun 02, 2020 at 01:50:37PM -0400, Sinan Kaya wrote:
>> Bjorn,
>>
>> On 6/1/2020 9:57 PM, Yicong Yang wrote:
>>> well, Sinan's words make sense to me. But I'm still confused that, 
>>> the message
>>> says we're "disabling ASPM" but ASPM maybe enabled if we designate
>>> pcie_aspm=force as I mentioned in the commit message. Will it be 
>>> possible if
>>> we replace "disabling" to "disabled" or we can do something else to 
>>> make
>>> the message reflect the real status of ASPM?
>>
>> What do you think?
>
> ASPM is a mess in general, and the whole "no_aspm" dance for delaying
> setting of aspm_disabled is ... well, it's confusing at best.
>
> These "_OSC failed" messages are confusing to users as well.  They
> lead to bug reports against Linux (when it's usually a BIOS problem)
> and users booting with "pcie_aspm=force" (which is a poor user
> experience and potentially dangerous since the platform hasn't granted
> us control of the PCIe Capability).
>
> And it's not even specific to ASPM; when _OSC fails, we don't take
> over *any* PCIe features.  At least, we're not *supposed* to -- I
> don't think we're very careful about random things in the PCIe
> capability.

I agree.  It also will become even more potentially confusing where _OSC 
fails for CXL.

>
> What if we just removed the ASPM text from the message completely,
> e.g., something like this:
>
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index 800a3d26d24b..49fdb07061b1 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -453,9 +453,8 @@ static void negotiate_os_control(struct 
> acpi_pci_root *root, int *no_aspm,
>  		if ((status == AE_NOT_FOUND) && !is_pcie)
>  			return;
>
> -		dev_info(&device->dev, "_OSC failed (%s)%s\n",
> -			 acpi_format_exception(status),
> -			 pcie_aspm_support_enabled() ? "; disabling ASPM" : "");
> +		dev_info(&device->dev, "_OSC: platform retains control of PCIe 
> features (%s)\n",
> +			 acpi_format_exception(status));
>  		return;
>  	}
>
> @@ -516,7 +515,7 @@ static void negotiate_os_control(struct 
> acpi_pci_root *root, int *no_aspm,
>  	} else {
>  		decode_osc_control(root, "OS requested", requested);
>  		decode_osc_control(root, "platform willing to grant", control);
> -		dev_info(&device->dev, "_OSC failed (%s); disabling ASPM\n",
> +		dev_info(&device->dev, "_OSC: platform retains control of PCIe 
> features (%s)\n",
>  			acpi_format_exception(status));
>

That looks good to me and I can add similar wording for CXL features in 
my patches.

Thanks,

Sean

>  		/*
