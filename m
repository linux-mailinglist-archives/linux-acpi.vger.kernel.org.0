Return-Path: <linux-acpi+bounces-2050-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6F380028D
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Dec 2023 05:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C40FCB20BFA
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Dec 2023 04:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3269C11710
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Dec 2023 04:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IehsnKDp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C8E1715
	for <linux-acpi@vger.kernel.org>; Thu, 30 Nov 2023 19:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701402525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/3AzxV0WgKZTUkZI9KNfIOtjrPxu2v3xdf2PUplwrRY=;
	b=IehsnKDpceSgaIQDLHo/5DCkfX5uLuD9JVxzz3GmZt04pjXM1ttJl4ZZKaYdHUw9ODXJEC
	9PZ+v7Zj0hJ1msRoTlGOlJla8DxxlEfi+onioHV+GWbApD0DBIWyuBwVu5ZLUREVr1GoMr
	eW/EG7YO6XYOwMUKzK8SIPp/ZFK8GQw=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-4YCsBvEBM5Wrg2XW_VF2dA-1; Thu, 30 Nov 2023 22:48:42 -0500
X-MC-Unique: 4YCsBvEBM5Wrg2XW_VF2dA-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1cfccc9d6bcso1560875ad.2
        for <linux-acpi@vger.kernel.org>; Thu, 30 Nov 2023 19:48:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701402521; x=1702007321;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/3AzxV0WgKZTUkZI9KNfIOtjrPxu2v3xdf2PUplwrRY=;
        b=D8N7vp4r2tTn5tDiIxQ/sh27xbKuBuF9EqUVzH+gaMWoDOrqnN9VxDHKKWDrlYX66q
         N/O3s6xYQn+MHCDqKHKeuQ9Ze6iYFx4qzZo5OmbOcveAYiVirU6Mt654ze36rM+drAHP
         681Mg2a+dX6G5l5lh1CIAt9/exiYBe0kpZb1CfcAHBNCv7582u8aOAfir+wT/1KW9cc+
         xHOrQWuG7hG4OfJOr0TA1DDQV/ED2uoMqaFOuikE9tgwI4j1sGwq5zS7yjj7+WZqCAGB
         HVoXJcoqQW/3YcacMUnTgNc3C+ig5jBI/fWITjI+KnXYiGvnxfUne7aCgOxZX2lsSctL
         +jTw==
X-Gm-Message-State: AOJu0YwhXy7E2BXYb15PKswH4glpIgaKYbBD60XYsdt9yH15c95Ro/rP
	6MCLBDKu39HcJKDFNAkcvflFTNpYBuilybUdTDdElX7e/0R00BLPDCLSUjKswyvlkbQzOZrNcs/
	fj1uwmXxeE8pl1HbyAUS5XQ==
X-Received: by 2002:a17:903:22cc:b0:1d0:1c45:fca6 with SMTP id y12-20020a17090322cc00b001d01c45fca6mr8848388plg.55.1701402521010;
        Thu, 30 Nov 2023 19:48:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFPJHgKJ9VKrBg6ysMgalrHEAISDmXhJQ0ZqsSvXKSLoKD01csDbzaLvkOj/ql3EV9F3wt2Rw==
X-Received: by 2002:a17:903:22cc:b0:1d0:1c45:fca6 with SMTP id y12-20020a17090322cc00b001d01c45fca6mr8848375plg.55.1701402520729;
        Thu, 30 Nov 2023 19:48:40 -0800 (PST)
Received: from [192.168.68.51] ([43.252.115.3])
        by smtp.gmail.com with ESMTPSA id p5-20020a170902e74500b001cfc1a593f7sm2185691plf.217.2023.11.30.19.48.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 19:48:40 -0800 (PST)
Message-ID: <86e58855-c5c9-42d0-b983-bf36a8b9b2b0@redhat.com>
Date: Fri, 1 Dec 2023 14:48:33 +1100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/21] drivers: base: Move cpu_dev_init() after
 node_dev_init()
Content-Language: en-US
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
 linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev, x86@kernel.org,
 linux-csky@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org
Cc: Salil Mehta <salil.mehta@huawei.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, jianyong.wu@arm.com,
 justin.he@arm.com, James Morse <james.morse@arm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>
References: <ZVyz/Ve5pPu8AWoA@shell.armlinux.org.uk>
 <E1r5R3R-00CszO-C0@rmk-PC.armlinux.org.uk>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <E1r5R3R-00CszO-C0@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/22/23 00:44, Russell King (Oracle) wrote:
> From: James Morse <james.morse@arm.com>
> 
> NUMA systems require the node descriptions to be ready before CPUs are
> registered. This is so that the node symlinks can be created in sysfs.
> 
> Currently no NUMA platform uses GENERIC_CPU_DEVICES, meaning that CPUs
> are registered by arch code, instead of cpu_dev_init().
> 
> Move cpu_dev_init() after node_dev_init() so that NUMA architectures
> can use GENERIC_CPU_DEVICES.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
> Note: Jonathan's comment still needs addressing - see
>    https://lore.kernel.org/r/20230914121612.00006ac7@Huawei.com
> ---
>   drivers/base/init.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


