Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55BF712AC4D
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Dec 2019 14:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725954AbfLZNCh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 26 Dec 2019 08:02:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59955 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726440AbfLZNCh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 26 Dec 2019 08:02:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577365356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5aEamWq7nLWLZ8ATUMzi/DS0XmBcftQ/KkilQfpBaX4=;
        b=QV+dOuPslFw9jE2X/yinx+MQdj78n53c+gGv/9XrxZUofdjzBPGqWeZmliBMHpw0pgsiP8
        VADdH0Wr/STnz0huLwMm6T5tGGLqHXq/b5ja+U+TpGZyMU2UBSOwj0fBVreAAUzeNjrMEN
        v4ujpo4z3AnbPShaqGb+Ja5xW/YbrDo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-14-KMn2BmxRM2q1vhzIjfw6RA-1; Thu, 26 Dec 2019 08:02:33 -0500
X-MC-Unique: KMn2BmxRM2q1vhzIjfw6RA-1
Received: by mail-wr1-f72.google.com with SMTP id y7so12430634wrm.3
        for <linux-acpi@vger.kernel.org>; Thu, 26 Dec 2019 05:02:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5aEamWq7nLWLZ8ATUMzi/DS0XmBcftQ/KkilQfpBaX4=;
        b=LkjZMrfycz+BfPR1pdn5lai7CSahSnWyeBA4p19ZILN1EwYqWxW+CJNK9QD54YiaaE
         XNL0i+AItq027Kgm43t+fBEczZTVFxDxV4YJ1NW/pezaBm7m54LJl/oMhHpDNTzU4npd
         APv7OwHR6EIWcC7XGm4S169HOAfLmmJOOuaxtTUsSBhGgu089/7IjVmiLVSOX1y8hwMf
         cvVOq1CkR+i8au177p+dcUOcka1o7erLHL3GsZ+BLcaDrhcGVb9Bp+hSXGimiK3ek/52
         pHtPXbKRzO9fJNQbX4VdIvOCilfxWpgGQJZS02nmJUgVpr92wl5rATGVkyo23G/g4TlV
         KuiQ==
X-Gm-Message-State: APjAAAVybb/QypRqQW9lRIW/vVpb24D547lDgaDQIoEwIOuHJpNKup1h
        tYXwJ05yFF0JuyBrm+mDmRIBJWf5VeLS1oLuM50LxOEJplWkUKg6L0mR1qFWmgiX/cspCLKpoNj
        2aq0TJkx0LKiDVLl5jRdkvw==
X-Received: by 2002:a05:6000:12c9:: with SMTP id l9mr47527859wrx.304.1577365352208;
        Thu, 26 Dec 2019 05:02:32 -0800 (PST)
X-Google-Smtp-Source: APXvYqxWvVTiX30mgHFVy5MoJjlKqVEzL3gxNEqM+bSe/fg2yubRgZOSstgjb30m0GS7jPb2rSBJDA==
X-Received: by 2002:a05:6000:12c9:: with SMTP id l9mr47527833wrx.304.1577365351990;
        Thu, 26 Dec 2019 05:02:31 -0800 (PST)
Received: from shalem.localdomain (2001-1c00-0c0c-fe00-7e79-4dac-39d0-9c14.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:7e79:4dac:39d0:9c14])
        by smtp.gmail.com with ESMTPSA id o129sm8511008wmb.1.2019.12.26.05.02.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Dec 2019 05:02:31 -0800 (PST)
Subject: Re: [PATCH] ACPI: video: Do not export a non working backlight
 interface on MSI MS-7721 boards
To:     Sasha Levin <sashal@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     linux-acpi@vger.kernel.org, stable@vger.kernel.org
References: <20191217190811.638607-1-hdegoede@redhat.com>
 <20191225235530.C65AD20838@mail.kernel.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <72606fb0-58dd-a415-b14d-b65ed53d3965@redhat.com>
Date:   Thu, 26 Dec 2019 14:02:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20191225235530.C65AD20838@mail.kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 26-12-2019 00:55, Sasha Levin wrote:
> Hi,
> 
> [This is an automated email]
> 
> This commit has been processed because it contains a -stable tag.
> The stable tag indicates that it's relevant for the following trees: all
> 
> The bot has tested the following trees: v5.4.5, v5.3.18, v4.19.90, v4.14.159, v4.9.206, v4.4.206.
> 
> v5.4.5: Build OK!
> v5.3.18: Build OK!
> v4.19.90: Build OK!
> v4.14.159: Build OK!
> v4.9.206: Failed to apply! Possible dependencies:
>      1f59ab2783ae ("ACPI / video: Add force_none quirk for Dell OptiPlex 9020M")
>      d37efb79bc1c ("ACPI / video: Add quirks for the Dell Precision 7510")
> 
> v4.4.206: Failed to apply! Possible dependencies:
>      1f59ab2783ae ("ACPI / video: Add force_none quirk for Dell OptiPlex 9020M")
>      d37efb79bc1c ("ACPI / video: Add quirks for the Dell Precision 7510")
> 
> 
> NOTE: The patch will not be queued to stable trees until it is upstream.
> 
> How should we proceed with this patch?

This fix is mostly cosmetical (it hides a non working brightness control
in various desktop environments) so just backporting this to the kernels
where it cleanly applies is fine.

Regards,

Hans

