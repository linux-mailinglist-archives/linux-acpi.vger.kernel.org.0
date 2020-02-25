Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4018216ECA7
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Feb 2020 18:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730708AbgBYRjo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 25 Feb 2020 12:39:44 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46239 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728051AbgBYRjo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 25 Feb 2020 12:39:44 -0500
Received: by mail-ot1-f68.google.com with SMTP id g64so250731otb.13
        for <linux-acpi@vger.kernel.org>; Tue, 25 Feb 2020 09:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7OXHupn/eABYBBL7B4Fti1b+jxOPDWyjuii0bnF4epM=;
        b=AE8Q7vZmTYokhYjcCu+0V8M12z+lMXneKH2KNQyQURj0mJ5EYfGOBlZk9Cj3yEKaVR
         mm3V63hec1VXGCQ/iaLeWsOxWOxiNWDPGHTVrHpPBL5t8BR8Ajx3EPC3vmx8LRSTsWIM
         II5YOPb1K3dkHPTSFl0naBblR59myCgaMB4LDU0u2knaidrssXHl9JAVXDiwBbi5V7q/
         AmzAfQlPoZPHMwOf9VjEunUG2SEQi3fTgeIVBJqdOv/8mIfmfU73SSC5CBxH23Lx6Jsj
         pfHR2UE4Nv1pT65soOHOCBjngHOnHUiMYI/dWnItqyW+iIa84DL9QblBgOt8Y8maWC1q
         oMiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7OXHupn/eABYBBL7B4Fti1b+jxOPDWyjuii0bnF4epM=;
        b=WZGUY3hOWcEcejMiCvE/I2g6jSijKu1irgR+tVAKg9Tnz/TSXHBRChcnPoQxvzbdCM
         H1B3D/m+gTjfL4UnInJigJ063/Q4NlGyUg0Zw8dtx9Rgmw6OlcQ9vV2yBEbz4DkL3x1g
         jEyM9edX69sEVJOZiAic3AmzXJL1nbGxOe/8eZqHOn648TgAxZk/cfMKK/pHf/8QNImu
         BQvc5SLd5/Zr8SZ91w2dF5K2QaqbWDqshyEQzDkum9szvQrze3a+WVlZASIGRJ8toEir
         oniuIhSXp2G0l1309CCYfpvsrebygpYmGZPp1af+s7XXUHiA/C2ThV7g98jhQBkl4cT6
         9hWw==
X-Gm-Message-State: APjAAAUzHNCG/P/GxWaRbpPkjsE24R9U4ix9nObNwWDVuLFivkJWMjfM
        BN+8w7Tk4+qZMfG81LyfckwFs7VVsmR56TDGnFSDTw==
X-Google-Smtp-Source: APXvYqwFDa7c/+xdMRI4xMWHsaudTDvmWW/yQIztlU6g8VlP3tvDXsNUwuJCiAlWSGRcL/rIhw1WqGwHAKcfPLxAWTE=
X-Received: by 2002:a9d:64d8:: with SMTP id n24mr42746705otl.71.1582652383462;
 Tue, 25 Feb 2020 09:39:43 -0800 (PST)
MIME-Version: 1.0
References: <20200225161927.hvftuq7kjn547fyj@kili.mountain>
In-Reply-To: <20200225161927.hvftuq7kjn547fyj@kili.mountain>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 25 Feb 2020 09:39:32 -0800
Message-ID: <CAPcyv4ht6kicLV_uk5Rt7a7iAxXrwuVoN2m6uVSw0h3qiE4AhA@mail.gmail.com>
Subject: Re: [PATCH 1/2] acpi/nfit: improve bounds checking for 'func'
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Feb 25, 2020 at 8:20 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> The 'func' variable can come from the user in the __nd_ioctl().  If it's
> too high then the (1 << func) shift in acpi_nfit_clear_to_send() is
> undefined.  In acpi_nfit_ctl() we pass 'func' to test_bit(func, &dsm_mask)
> which could result in an out of bounds access.
>
> To fix these issues, I introduced the NVDIMM_CMD_MAX (31) define and
> updated nfit_dsm_revid() to use that define as well instead of magic
> numbers.
>
> Fixes: 11189c1089da ("acpi/nfit: Fix command-supported detection")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

I'll apply this to my fixes branch.
