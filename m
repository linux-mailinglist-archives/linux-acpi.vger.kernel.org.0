Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45886198E1D
	for <lists+linux-acpi@lfdr.de>; Tue, 31 Mar 2020 10:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730012AbgCaIQ3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 31 Mar 2020 04:16:29 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:22255 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730007AbgCaIQ3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 31 Mar 2020 04:16:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585642588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0KEXjDpdkfzHGYc11MseadUyHXSxJBFAffB+nwY1U/g=;
        b=H5BLvCbc4lzazQ+uW9HiGB5uSl91PhU6u4B+J4h3aSSTSQTxohUVxJditmIdW8rNndY28J
        PkpbIOndhj3bo8RYJFdJ/YrgOY0DHw4ZxJeEXLY/qde46xPJmZ1tYRE+/51TXEuCkHUwUD
        gyyZdtaigMu7X2PoH662qRqR0e7ha28=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-4h9Z4vX-M-utmljnTHD6iQ-1; Tue, 31 Mar 2020 04:16:26 -0400
X-MC-Unique: 4h9Z4vX-M-utmljnTHD6iQ-1
Received: by mail-wm1-f72.google.com with SMTP id s15so408794wmc.0
        for <linux-acpi@vger.kernel.org>; Tue, 31 Mar 2020 01:16:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0KEXjDpdkfzHGYc11MseadUyHXSxJBFAffB+nwY1U/g=;
        b=mSGD1sNTrY99WXkyjkwZ7ls/RMX7Be/+vFqxZBRYkqbTJj1CD+is3SDfpIhpL6DGVn
         lW61ofyuB5FSRFSZEnyedUD0fP2AFvpO12IaKtUwjrybpRVyXnnyBAC55er7xgmf84LB
         VpJFRzWDI+IEq5GKXK6W/h2g6Y3QYdJlZ4k7jDmwqfvVRJsthXQKfDb2H18Az94PTaLE
         gsFsDXLdfkLil57AN/wSrdI747/Mxe1CV5jp/xMKfe2L/bos9pKB/FkJLyIQXtPD3gBO
         LTO5eeHRsNLPolDarNKoJDupScsMkgb5l1PcJN9NjNoluEvj6aTGmcWmZ2p9l2M4NGGX
         6y1w==
X-Gm-Message-State: ANhLgQ3UqIHnBGRa0Uenq92vBa+vSs33pCfLnNViv/hv+C3pTp6L8Vqq
        7t501h3lvjvs3iblXCtVuJ9ukw6KzTJpy0KSWKEKrXoZsl3gv45Le6JmtF9YmPcSv3jOGvA5L25
        feXE1Y/DBZoO5aYU38Tkm2Q==
X-Received: by 2002:a1c:b657:: with SMTP id g84mr2164604wmf.107.1585642585527;
        Tue, 31 Mar 2020 01:16:25 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vv0D8PbQSNyZJuByypmQwlp7VqNiGfkNYGvcYmg07TfkZmLPoOr3o3JKc2z0GnUlCHHAhkomA==
X-Received: by 2002:a1c:b657:: with SMTP id g84mr2164596wmf.107.1585642585366;
        Tue, 31 Mar 2020 01:16:25 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-fc7e-fd47-85c1-1ab3.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:fc7e:fd47:85c1:1ab3])
        by smtp.gmail.com with ESMTPSA id q9sm2195041wrp.84.2020.03.31.01.16.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2020 01:16:24 -0700 (PDT)
Subject: Re: [PATCH] ACPI; update docs for "acpi_backlight" kernel parameter
 options
To:     Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        ACPI Devel Mailing List <linux-acpi@vger.kernel.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
References: <19409af2-f38a-6760-c7b3-aa5794a94df0@infradead.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <c292826f-0a41-910d-1973-e6b613fbce7e@redhat.com>
Date:   Tue, 31 Mar 2020 10:16:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <19409af2-f38a-6760-c7b3-aa5794a94df0@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 3/31/20 2:17 AM, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Update the Documentation for "acpi_backlight" by adding
> 2 new options (native and none).
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: linux-acpi@vger.kernel.org
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Len Brown <lenb@kernel.org>

Thanks!

Patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans




> ---
>   Documentation/admin-guide/kernel-parameters.txt |    8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> --- linux-next-20200330.orig/Documentation/admin-guide/kernel-parameters.txt
> +++ linux-next-20200330/Documentation/admin-guide/kernel-parameters.txt
> @@ -22,11 +22,13 @@
>   			default: 0
>   
>   	acpi_backlight=	[HW,ACPI]
> -			acpi_backlight=vendor
> -			acpi_backlight=video
> -			If set to vendor, prefer vendor specific driver
> +			{ vendor | video | native | none }
> +			If set to vendor, prefer vendor-specific driver
>   			(e.g. thinkpad_acpi, sony_acpi, etc.) instead
>   			of the ACPI video.ko driver.
> +			If set to video, use the ACPI video.ko driver.
> +			If set to native, use the device's native backlight mode.
> +			If set to none, disable the ACPI backlight interface.
>   
>   	acpi_force_32bit_fadt_addr
>   			force FADT to use 32 bit addresses rather than the
> 

