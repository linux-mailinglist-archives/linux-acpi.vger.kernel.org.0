Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 613A81243EB
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Dec 2019 11:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbfLRKFt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 18 Dec 2019 05:05:49 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30827 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725799AbfLRKFt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 18 Dec 2019 05:05:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576663547;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FSkrFpm1DW1Y7i6HiHHtFhN9Nhr2jT7JhuCbqt9yG0o=;
        b=HMa3mKavab7DQS2DFwwIWWNhmOmZWMoMFVdu21e8w+LbkG5UedcBRm3DMMoXm5yatDYskF
        XuBIJf+ESBkOnB3GNvphc2Kr9h8rprswGAqZ5vwMjqNdDOXIOXoYiVw4vSLNsKONzjx/fc
        dSOcv6KPjh0GosY2FFeODBSihENLfQE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-72-8FvJB1SgO4KXULxGU_T0eA-1; Wed, 18 Dec 2019 05:05:44 -0500
X-MC-Unique: 8FvJB1SgO4KXULxGU_T0eA-1
Received: by mail-wr1-f70.google.com with SMTP id w6so654875wrm.16
        for <linux-acpi@vger.kernel.org>; Wed, 18 Dec 2019 02:05:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FSkrFpm1DW1Y7i6HiHHtFhN9Nhr2jT7JhuCbqt9yG0o=;
        b=SnG/x6tLyIcp4RlLqF2SyO1OJuHcOUXgOnQdNXzn5/efnCKjz8n/9+l8Nn7XMEsH0C
         EUNslHLJLbKf+bUrdqdt2cvhCc2H4WjJnzq2ZLU/bxJjzojYmasC9g9Tv4Pqpuea7QL2
         UNKHwW1U4JjnY2/BxfnTWWmz07nh6t7FESrOxQLH3crgzKmV6Ca0gG6qFrYZheyIi9Zn
         DHfvIUJbqBcOR2watv+fp7lGEh/mKDjsXuKQdW0DsVpcIu8vQFSPv25NKJ3TfVjSuFVX
         u1SNL46nylQ0EbhGY/dCcwngYglcseYRCbyjfQiFUyQFe31rkRI+/PxxL49IeUNeAzTO
         GrFQ==
X-Gm-Message-State: APjAAAXMyJXus2cFzf+jXrUV9gMeFlPODHXhhicL/5FwHENTHZyUG5Xz
        laINLK1t0d7FHK5/IEpd+q0OPCrdonf/ssT1xEzv4So8TlAmj6h1kGQDgYIp1qv0BfjpL5EhldO
        Gu3N2Nlaqiy7RBVYlQKDW9Q==
X-Received: by 2002:adf:f54d:: with SMTP id j13mr499098wrp.19.1576663542492;
        Wed, 18 Dec 2019 02:05:42 -0800 (PST)
X-Google-Smtp-Source: APXvYqxX6RhlxdEWJs66pu6RNx9WXgk/AjvVABJfgEXDOjUWKh9KkobAdo1xitp5e/cWXJ63qptzmA==
X-Received: by 2002:adf:f54d:: with SMTP id j13mr499080wrp.19.1576663542320;
        Wed, 18 Dec 2019 02:05:42 -0800 (PST)
Received: from shalem.localdomain (2001-1c00-0c0c-fe00-7e79-4dac-39d0-9c14.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:7e79:4dac:39d0:9c14])
        by smtp.gmail.com with ESMTPSA id 5sm2130892wrh.5.2019.12.18.02.05.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Dec 2019 02:05:41 -0800 (PST)
Subject: Re: [PATCH] serdev: Don't claim unsupported serial devices
To:     Punit Agrawal <punit1.agrawal@toshiba.co.jp>,
        linux-serial@vger.kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        nobuhiro1.iwamatsu@toshiba.co.jp, shrirang.bagul@canonical.com,
        stable@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>
References: <20191218065646.817493-1-punit1.agrawal@toshiba.co.jp>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <096046b6-324a-8496-8599-ed7e5ffc6e3c@redhat.com>
Date:   Wed, 18 Dec 2019 11:05:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191218065646.817493-1-punit1.agrawal@toshiba.co.jp>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 18-12-2019 07:56, Punit Agrawal wrote:
> Serdev sub-system claims all serial devices that are not already
> enumerated. As a result, no device node is created for serial port on
> certain boards such as the Apollo Lake based UP2. This has the
> unintended consequence of not being able to raise the login prompt via
> serial connection.
> 
> Introduce a blacklist to reject devices that should not be treated as
> a serdev device. Add the Intel HS UART peripheral ids to the blacklist
> to bring back serial port on SoCs carrying them.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Johan Hovold <johan@kernel.org>
> Cc: Hans de Goede <hdegoede@redhat.com>

Thank you for addressing this long standing issue.

The basic approach here looks good to me, once the minor
comments from other reviewers are addressed you can add my:

Acked-by: Hans de Goede <hdegoede@redhat.com>

to the next version.

Regards,

Hans



> ---
> 
> Hi,
> 
> The patch has been updated based on feedback recieved on the RFC[0].
> 
> Please consider merging if there are no objections.
> 
> Thanks,
> Punit
> 
> [0] https://www.spinics.net/lists/linux-serial/msg36646.html
> 
>   drivers/tty/serdev/core.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
> index 226adeec2aed..0d64fb7d4f36 100644
> --- a/drivers/tty/serdev/core.c
> +++ b/drivers/tty/serdev/core.c
> @@ -663,6 +663,12 @@ static acpi_status acpi_serdev_register_device(struct serdev_controller *ctrl,
>   	return AE_OK;
>   }
>   
> +static const struct acpi_device_id serdev_blacklist_devices[] = {
> +	{"INT3511", 0},
> +	{"INT3512", 0},
> +	{ },
> +};
> +
>   static acpi_status acpi_serdev_add_device(acpi_handle handle, u32 level,
>   					  void *data, void **return_value)
>   {
> @@ -675,6 +681,10 @@ static acpi_status acpi_serdev_add_device(acpi_handle handle, u32 level,
>   	if (acpi_device_enumerated(adev))
>   		return AE_OK;
>   
> +	/* Skip if black listed */
> +	if (!acpi_match_device_ids(adev, serdev_blacklist_devices))
> +		return AE_OK;
> +
>   	if (acpi_serdev_check_resources(ctrl, adev))
>   		return AE_OK;
>   
> 

