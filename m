Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 411611A7A5B
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Apr 2020 14:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439895AbgDNMI5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 14 Apr 2020 08:08:57 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55539 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729745AbgDNMIw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 14 Apr 2020 08:08:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586866130;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=74+NBoVwwCLwEv4kMoUPHSjG1LhHKGIGgc4Wi5obL7E=;
        b=h5DdI4pWyWUJaCskjGBJ4oty3B3iWxPulRkGIH+giL5mnGKKb8y8B84BnAPBjo1dYQcFz3
        iZx7WN89VhG9CSiBuEvFYTrfETBh7SVpFCvTpssn+wLDORMqIxL6h2yCfVdM6z48LRAO39
        jEVryHNO2yrWWPGAc5F2p0/v2J67U8I=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-uzNHfD_UN5C8-RfcjIXXFw-1; Tue, 14 Apr 2020 08:08:45 -0400
X-MC-Unique: uzNHfD_UN5C8-RfcjIXXFw-1
Received: by mail-wr1-f69.google.com with SMTP id g6so8542600wru.8
        for <linux-acpi@vger.kernel.org>; Tue, 14 Apr 2020 05:08:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=74+NBoVwwCLwEv4kMoUPHSjG1LhHKGIGgc4Wi5obL7E=;
        b=srkYaVdziZe2gnXBa2TrEILXYX/t/xLEebTC5wiX20LHvn+HTiR5qwZYbMh/X2oLye
         fFhktgyPNbmvfKL6UVq9uDMamCcN5GvrPqLuTmgTtWxp0V9foHXMrkAaP0RJ+xiDx+2o
         zWCVMaKGlXi1Q+Et3tylme94y0uz3jZJYGhcJbfKeQCX4xloo54CkUnLwWZCl+7pO5ho
         41ELJ10iQiAuTnhwPdkFLfBsD0TcmBf04ANsF2M5FsKJmoNSdTeMsXxU9rwh+OCRwdvd
         nTc/w5mb5x4cfAg2Jc+m6RQAQ7AoyfgQ0BfiGsvtWmEyKF5PSOh5TRj0ppXAOttK4ttU
         IogQ==
X-Gm-Message-State: AGi0PuaH1COwDuS9yaAgJPMFuwXxMiaGrTmPYKARZwTPRZD5nPBsFH/I
        AyY5vGReD2LgFxa8hCQhVYcDkvovCwZjwlCyRQn/ylr5x5vcEZjRgsO0JIM/bKtdlU6vA6z6YcU
        Vb+6AL8+GdxXn7DqLFADY1g==
X-Received: by 2002:adf:edcc:: with SMTP id v12mr6902492wro.317.1586866124229;
        Tue, 14 Apr 2020 05:08:44 -0700 (PDT)
X-Google-Smtp-Source: APiQypInYtHPsLVtRyg24LFQXGyoaVYx3cqklTOGEvqf6qsZ9/7yOIVtIBJpnmfTL5QQ8Q+LS63Gtw==
X-Received: by 2002:adf:edcc:: with SMTP id v12mr6902444wro.317.1586866123656;
        Tue, 14 Apr 2020 05:08:43 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id c18sm18447731wrx.5.2020.04.14.05.08.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2020 05:08:43 -0700 (PDT)
Subject: Re: [PATCH v1 0/6] platform/x86: intel_cht_int33fe: clean up series
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        platform-driver-x86@vger.kernel.org,
        Darren Hart <dvhart@infradead.org>
References: <20200408160905.12101-1-andriy.shevchenko@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <9aa81292-70c2-c12a-ded1-1164faac0024@redhat.com>
Date:   Tue, 14 Apr 2020 14:08:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200408160905.12101-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 4/8/20 6:09 PM, Andy Shevchenko wrote:
> When I started looking into the intel_cht_int33fe driver for an example of use
> software node API, I have noticed that it's hard to get and code a bit messy.
> Here is a clean up, main part of which is to introduce node groups and API to
> register and unregister them. This and some pre-existing APIs can be used in
> the driver.
> 
> So, because of cross-subsystem nature of this series, I may recommend to create
> myself the immutable branch which can be pulled to Rafael's and Greg's trees
> respectively. I'm also open for other proposals how to proceed.

The series looks good to me and I've also tested it on one of
the devices using the intel_cht_int33fe driver and everything seems
to work fine, so for the whole series:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Tested-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans





> 
> Andy Shevchenko (6):
>    device property: export set_secondary_fwnode() to modules
>    software node: Allow register and unregister software node groups
>    platform/x86: intel_cht_int33fe: Convert software node array to group
>    platform/x86: intel_cht_int33fe: Convert to use set_secondary_fwnode()
>    platform/x86: intel_cht_int33fe: Switch to use
>      acpi_dev_hid_uid_match()
>    platform/x86: intel_cht_int33fe: Fix spelling issues
> 
>   drivers/base/core.c                           |   1 +
>   drivers/base/swnode.c                         |  48 ++++++++
>   .../platform/x86/intel_cht_int33fe_typec.c    | 106 +++++++++---------
>   include/linux/property.h                      |   3 +
>   4 files changed, 108 insertions(+), 50 deletions(-)
> 

