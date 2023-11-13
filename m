Return-Path: <linux-acpi+bounces-1445-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A386A7E9641
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Nov 2023 05:34:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BA2C280DDE
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Nov 2023 04:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27161A58E
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Nov 2023 04:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CqiSUF2O"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209171170E
	for <linux-acpi@vger.kernel.org>; Mon, 13 Nov 2023 04:24:41 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68BB8173E
	for <linux-acpi@vger.kernel.org>; Sun, 12 Nov 2023 20:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699849478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+XpkXMncYpwBWWz5YM4lExGVyIZbJdd8k4LtapRIRSU=;
	b=CqiSUF2OOoz7FDL8zJB1fpVBOFcXzYHcqyThP9jZgY4tu7iXzvwbC8ZhMoGYldCriGk3uF
	aRzYE69HUo44bFM8lx7cmgMcaXmnaKS4dWO6j5qm9HYPwlZMzJpU3LQVpCboPJppZMQ9g5
	VWTmZTRlDhmu6IH28mpkhmgqsUuhzEw=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-WnnQuXjzPbSRIO3lvV9cDg-1; Sun, 12 Nov 2023 23:24:36 -0500
X-MC-Unique: WnnQuXjzPbSRIO3lvV9cDg-1
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3b3e601436cso4676689b6e.1
        for <linux-acpi@vger.kernel.org>; Sun, 12 Nov 2023 20:24:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699849475; x=1700454275;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+XpkXMncYpwBWWz5YM4lExGVyIZbJdd8k4LtapRIRSU=;
        b=lwOFf2ibk2xCLbuolDHml8m6CUQe29axy+U5saJ4XNCQTibnAvZcXqdfEAooV7LTtv
         PuCUh8PzbCdaqFAmENNRsXBuvOGFmrlACc5mvfrqU7kg5uwD2mHWpKWMdEq+D0W2//sQ
         rfZ5xWnE5jctVulqCW/uArAOUuMLc2ky/vsDN9viiIZm53SdUc9zdu8B7vW9fTJwKoKp
         XpCsYvJE+CDP4hymM98inWsHmN+xES3DEtj3aLdMMCuK8rXRBmuZe/p2Y8mKwxg6siEG
         u3/v2yXK7XU60Xcscfne6KWjE8k9i3MdLpMsCQuxXwqGw11VQIk9F8jfdF2HCWyGpZ3L
         CCpA==
X-Gm-Message-State: AOJu0YxWPk8Cc6VQGySxakP9aj+DszjrV6D6JeeUQP+Resz7R1DrVi0D
	Esx0UkiPT3im6UdzsVmCu/KyBADUqGpgsn8R5sFKHm2RB8HLWfIPN79OqGNqrLfB6iC5+qPKUQ9
	Et6DOd/NRibSGfuQHLQSW2w==
X-Received: by 2002:a05:6808:1907:b0:3b2:a9bd:c38f with SMTP id bf7-20020a056808190700b003b2a9bdc38fmr8909960oib.37.1699849475408;
        Sun, 12 Nov 2023 20:24:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFGpLquY73YkMUU9Mlaw3xcZEgmE+1wMz9SoOzUS3eERBYDajACgA3kg4BM9OvwoIC+iQZINQ==
X-Received: by 2002:a05:6808:1907:b0:3b2:a9bd:c38f with SMTP id bf7-20020a056808190700b003b2a9bdc38fmr8909944oib.37.1699849475200;
        Sun, 12 Nov 2023 20:24:35 -0800 (PST)
Received: from ?IPV6:2001:8003:e5b0:9f00:b890:3e54:96bb:2a15? ([2001:8003:e5b0:9f00:b890:3e54:96bb:2a15])
        by smtp.gmail.com with ESMTPSA id fm6-20020a056a002f8600b006c4db182074sm3111661pfb.196.2023.11.12.20.24.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Nov 2023 20:24:34 -0800 (PST)
Message-ID: <d07a9e11-9752-4155-bbaf-b759ec4f99ac@redhat.com>
Date: Mon, 13 Nov 2023 14:24:27 +1000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 22/22] riscv: convert to use
 arch_cpu_is_hotpluggable()
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
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
References: <ZUoRY33AAHMc5ThW@shell.armlinux.org.uk>
 <E1r0JMV-00CTyh-It@rmk-PC.armlinux.org.uk>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <E1r0JMV-00CTyh-It@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/7/23 20:31, Russell King (Oracle) wrote:
> Convert riscv to use the arch_cpu_is_hotpluggable() helper rather than
> arch_register_cpu().
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>   arch/riscv/kernel/setup.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


