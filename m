Return-Path: <linux-acpi+bounces-20639-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOdoODJLeGn2pAEAu9opvQ
	(envelope-from <linux-acpi+bounces-20639-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 06:20:50 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3C990136
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 06:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 67F07300D366
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 05:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824CA32939B;
	Tue, 27 Jan 2026 05:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QutnZT+M"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3755B283FEA
	for <linux-acpi@vger.kernel.org>; Tue, 27 Jan 2026 05:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769491245; cv=none; b=JLgCI2A2utEH3PHcRVi9wrDicK2zcGaQlAQlgSqJP9VBqugiQFlvTD9J/646wzokj20eYWXkdFTzOZksIfCpjasYHDgjn3RJMmWTkWHNwDgud60kLvqzfvzMzcHXOkYhIIhjzpogrdoQEN+IMUMUo2F1/1uDd5zTNG5jh/pXSoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769491245; c=relaxed/simple;
	bh=mZBl8GIUWmM/EKOTDFkupIvO4PA/8SXCYwuoqP2UO7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GHPFz2MzCryYMvgXLVtfNpXtl63m41CVh1GftVjExe5M0EccoqHYKu6IOkTYtlLI649bPsdERP1fZTEuiDRpxBJiTaCz5jXrMpBaImpV/ZtGbU3Q08UCVTaoW9CfBLj9vpJnl/GsbCDIJKrP+HGUZo6qTX+fIyDTeyuWT8n6gRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QutnZT+M; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a743050256so34707305ad.3
        for <linux-acpi@vger.kernel.org>; Mon, 26 Jan 2026 21:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769491243; x=1770096043; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F6wAX1Zovj19NzcpBaNON6pwgReLt1GKp42ZyseUkIE=;
        b=QutnZT+MereIHCgpwFI3PtcEGMx4hd2qXDNQ6GfnbPnPpVhXjyr8tSZQFbcyz3jDO/
         84ltF1qGPr2a7CPpiu4rsQH5vNEA2B0nmWHZI++mIitEQotOPMbR/8d9Mlat0ekjv3gl
         60D//y/vu5GTmK6MJtlSoCXH8Ou3TZ4LGPtode85TAYtEJiUIe0TCLBAtBQTpvfZQbFi
         heKTjJIxpvQnvLJPcetadWzbyrMGXYlqXbvppefNWrIPBKLWP8M1b4SKsRCv6BzpRljG
         PuQI3kC0Xevd/2TUUrdmvn6cez75xhv5q8JwSZelekXiNt1U/MdixOlQP8tOSqp1YjVa
         +BEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769491243; x=1770096043;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F6wAX1Zovj19NzcpBaNON6pwgReLt1GKp42ZyseUkIE=;
        b=YtKpfOys+fadxAZSNP67sp2uGLeThtKEJ3Rlxcr3wkwDs47XxURGT/6pm12T5Xsg+a
         D8yNQ7WNXrn48DJm5tpsphIKTTmTrRfKkLwmAZLzt3aHga295bGtCdHhRdf2GZB2UFs1
         Fgp1fT3otCCYJxdSHIL+TZPfgwhuwBgMvkw9Khuf/8eIEBa7UCB08xIQ9MEptsVU7Tve
         9WpqBsNdHLyANKYhhPekHEKLzLF5cJbyU9heSBPg0H4kxSPgeXHdVa5cVFQw7V2+2O1N
         XPYgq5v8KMcYQnMPIb2gipdnPlNNqytT5QCShW6ReuHOYVp7MsdE68QdH3Z28doeF8E9
         Zd5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUPw6HDpSZ0zPHHQRZbJaI+hTJQ5ztScDgVTSjGejZ+61vJq0CierBopnWC7aYqUzaWAn9XdNZPKvbI@vger.kernel.org
X-Gm-Message-State: AOJu0YzRIT4kXsl7tOO4D32aaV+PlDZZsYhlzoflLiuDHPPpSDoEr0ha
	Bi+MuVy83t/Apz7dMJya8dsy6AEkfjesXcLKwj+5cT+ikNvahI4yYsk6ySyqTvekafc=
X-Gm-Gg: AZuq6aJyg/tz4E/t0lEy0nWegDF7Ie/h/EAAlG2/ztZnJBVfjPLJPa8BgazmDP3Iz5C
	jyme2rY8xMgdShy5xWeyUAaKVgNJBYffhhfL0IKTIPTq0rEXg1ie2jMaFDQ8s+lE7aDleHpWUAU
	u6EjclmLJl8fhHSLISIN/vx0NTfqV4aS2GHsx8moEjUGxkRAr/QDQ+WCFDLs6nyuW6vS5LWxX6P
	sKgodNw9WOzfKLgb5+NTsvYJwqXLdMvZdT9LM5QDd+SSqqGC4Xmy//bfKCH9t447hGfFWaHLzCU
	GB5foXhSh/YlbU94Fyn3/U5ZtyrxgtYMcEZGUpEgxUYjHXVSV9G91nfBMPDcwL1PGJ9Ga9FKp7B
	NCshb2YRVun4WjaS28Ug4bfu3C63lXEsNCggdYEsgKAHM4SFm1tmPbtfhtl+02UPkN09sKcQcdt
	NhvZvRW9nm1ac=
X-Received: by 2002:a17:903:22d2:b0:2a7:5751:5b27 with SMTP id d9443c01a7336-2a870e192ecmr6697375ad.39.1769491243136;
        Mon, 26 Jan 2026 21:20:43 -0800 (PST)
Received: from localhost ([122.172.80.63])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802dcd9e1sm102853215ad.25.2026.01.26.21.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 21:20:42 -0800 (PST)
Date: Tue, 27 Jan 2026 10:50:39 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Igor Korotin <igor.korotin.linux@gmail.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Len Brown <lenb@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 2/4] rust: cpufreq: import pin_init::zeroed() from ffi
Message-ID: <qkp35jvv2bpoqtuash5uok2krhzjfnpyxzflsndyv6gxrkk7th@7b2gjgibhtnz>
References: <20260126-zeroable-ffi-v1-0-0ef101d1ed85@google.com>
 <20260126-zeroable-ffi-v1-2-0ef101d1ed85@google.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126-zeroable-ffi-v1-2-0ef101d1ed85@google.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20639-lists,linux-acpi=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,garyguo.net,protonmail.com,umich.edu,collabora.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viresh.kumar@linaro.org,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linaro.org:email,linaro.org:dkim]
X-Rspamd-Queue-Id: 7C3C990136
X-Rspamd-Action: no action

On 26-01-26, 13:05, Alice Ryhl wrote:
> The zeroed() helper was re-exported from the ffi crate. As this usage of
> zeroed() has nothing to do with pin-init, use the new re-export.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/cpufreq.rs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
> index f968fbd22890546db1758d921e3374359ef9d00b..fadba8e669be33911a30be0254d3d4dcba9f4226 100644
> --- a/rust/kernel/cpufreq.rs
> +++ b/rust/kernel/cpufreq.rs
> @@ -1012,7 +1012,7 @@ impl<T: Driver> Registration<T> {
>          } else {
>              None
>          },
> -        ..pin_init::zeroed()
> +        ..ffi::zeroed()
>      };
>  
>      const fn copy_name(name: &'static CStr) -> [c_char; CPUFREQ_NAME_LEN] {

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

