Return-Path: <linux-acpi+bounces-2129-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D22E1803D2D
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Dec 2023 19:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00DFC1C208DB
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Dec 2023 18:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605E22FC24
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Dec 2023 18:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NXLZgYIr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BBCAFF
	for <linux-acpi@vger.kernel.org>; Mon,  4 Dec 2023 10:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701712912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bgk9x1S32YbyFYXGxABkNOgzyytMxhu0dcjiBukmT2Y=;
	b=NXLZgYIru64MZ+CZk0R2R/wn3ozfRE4c+Xutq2k0wX6sZdVRFtrLUtt4edN4KbWXCdi57p
	O5CEhYq/bjxt8PMaH0OQE1tMwKd3sYUFbU8+CSawyjZ3bRV1jXfcnt6yCJWu/2uC0UDeCr
	swwBCJ/rLD9AQWIsN9GTDwvvbSy6rfY=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-M17fxDznNiexjEakFuC7Ew-1; Mon, 04 Dec 2023 13:01:51 -0500
X-MC-Unique: M17fxDznNiexjEakFuC7Ew-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-77de7dacb57so428454385a.3
        for <linux-acpi@vger.kernel.org>; Mon, 04 Dec 2023 10:01:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701712910; x=1702317710;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bgk9x1S32YbyFYXGxABkNOgzyytMxhu0dcjiBukmT2Y=;
        b=LdeKCnHI6llseMsImShgznY9EsYVsmVPlRPWAn/w1rjN/JipdqzbUBSE+DVXnog0cV
         zYc7ki7ZRtUNbAnvEYuslVLIH97N5HDicujuD6r9tnWOdJ4KY7tVLjkOx+tKnnXgsN98
         xt9/rG8sYAR9NYUuQPUNrq9gXzZZb7xSP0TOBSuz9i+Svvx7hmU6GZKOFmEQZ5lt54WB
         /X6dgG0lNRhWcWb35hX+fx59Z6/y84QUgLqyBlagGGn+JdHmrtplL6U+Sfelqk/FLH2s
         cwgAfo2gS7NOtpZYKYfFCgyHoQ6d9WTDKoQHda9uKNlyByQK5p2308eZGaYAvaE5qjYL
         z7Xw==
X-Gm-Message-State: AOJu0YwM3Ejg8rm4sqkcs8ZsW7pk+fRcWuWPe1tSE5l95FTQ0sF3hXPV
	O5RiJ9bo4knynoiey8j9ICWGNggXt8884kq0HmgVskCMTjdh+6fex83eIqXMA8OON7PYN+dnmOF
	pDy+LhJQX5ZuoEOv5YHofAA==
X-Received: by 2002:a05:620a:1d08:b0:76f:d65:af24 with SMTP id dl8-20020a05620a1d0800b0076f0d65af24mr6184518qkb.27.1701712910556;
        Mon, 04 Dec 2023 10:01:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHQb6iGQRFDsjsW47QtTUSChPuX7AEzvmrR3xoj2Dr2YRJaCUeHyzkIKktc/Mz92zwG+o7y7Q==
X-Received: by 2002:a05:620a:1d08:b0:76f:d65:af24 with SMTP id dl8-20020a05620a1d0800b0076f0d65af24mr6184503qkb.27.1701712910247;
        Mon, 04 Dec 2023 10:01:50 -0800 (PST)
Received: from [10.16.200.42] (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id j5-20020a05620a288500b0077d8526bcdesm4421229qkp.86.2023.12.04.10.01.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 10:01:49 -0800 (PST)
Message-ID: <61b5e9bd-3b09-4580-ace1-01d3d361c79d@redhat.com>
Date: Mon, 4 Dec 2023 13:01:48 -0500
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: extlog fix null dereference check
Content-Language: en-US
To: linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 linux-acpi@vger.kernel.org, David Arcari <darcari@redhat.com>,
 Don Zickus <dzickus@redhat.com>, David Malcolm <dmalcolm@redhat.com>
References: <20231204180037.383583-1-prarit@redhat.com>
From: Prarit Bhargava <prarit@redhat.com>
In-Reply-To: <20231204180037.383583-1-prarit@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Top posting and just adding a few interested parties ...

On 12/4/23 13:00, Prarit Bhargava wrote:
> The gcc plugin -fanalyzer [1] tries to detect various
> patterns of incorrect behaviour.  The tool reports
> 
> drivers/acpi/acpi_extlog.c: In function ‘extlog_exit’:
> drivers/acpi/acpi_extlog.c:307:12: warning: check of ‘extlog_l1_addr’ for NULL after already dereferencing it [-Wanalyzer-deref-before-check]
>      |
>      |  306 |         ((struct extlog_l1_head *)extlog_l1_addr)->flags &= ~FLAG_OS_OPTIN;
>      |      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
>      |      |                                                  |
>      |      |                                                  (1) pointer ‘extlog_l1_addr’ is dereferenced here
>      |  307 |         if (extlog_l1_addr)
>      |      |            ~
>      |      |            |
>      |      |            (2) pointer ‘extlog_l1_addr’ is checked for NULL here but it was already dereferenced at (1)
>      |
> 
> Fix the null dereference check in extlog_exit().
> 
> [1] https://gcc.gnu.org/onlinedocs/gcc-10.1.0/gcc/Static-Analyzer-Options.html
> 
> CC: "Rafael J. Wysocki" <rafael@kernel.org>
> CC: Len Brown <lenb@kernel.org>
> CC: linux-acpi@vger.kernel.org
> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
> ---
>   drivers/acpi/acpi_extlog.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
> index e120a96e1eae..193147769146 100644
> --- a/drivers/acpi/acpi_extlog.c
> +++ b/drivers/acpi/acpi_extlog.c
> @@ -303,9 +303,10 @@ static int __init extlog_init(void)
>   static void __exit extlog_exit(void)
>   {
>   	mce_unregister_decode_chain(&extlog_mce_dec);
> -	((struct extlog_l1_head *)extlog_l1_addr)->flags &= ~FLAG_OS_OPTIN;
> -	if (extlog_l1_addr)
> +	if (extlog_l1_addr) {
> +		((struct extlog_l1_head *)extlog_l1_addr)->flags &= ~FLAG_OS_OPTIN;
>   		acpi_os_unmap_iomem(extlog_l1_addr, l1_size);
> +	}
>   	if (elog_addr)
>   		acpi_os_unmap_iomem(elog_addr, elog_size);
>   	release_mem_region(elog_base, elog_size);


