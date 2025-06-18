Return-Path: <linux-acpi+bounces-14448-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97236ADF144
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Jun 2025 17:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 496461BC0BC3
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Jun 2025 15:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24EEA2F0C60;
	Wed, 18 Jun 2025 15:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r3rKuG+x"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7077F2EF9B8
	for <linux-acpi@vger.kernel.org>; Wed, 18 Jun 2025 15:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750260106; cv=none; b=SCXduChXmPZFDUBmRpQxmdND1Gbem9kVjadU7UfxOuEO6+hijUWTayKS/t3P8cksKhiYsr7XsmOGo4mKdaZ9njieft3Dd44RnY2rSLoCU3M4Dwa7nMHmkUVuiqF+ikP6nanstje9dTiflzGN4OBhoC7sD8DGZ2afW6JwbTnzzVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750260106; c=relaxed/simple;
	bh=g07THXNWgAdEHWIqoiEHlcfwthoxZVyVXkEAgRexV0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VCqKs+Nyq6RxAq4mwPsUbIvdFhg8Vb/Lsr9cc+nqQLW/4DKh7i/lZZQJBtGGeDZMbPYkw0KWOHgn9pYzOSyxkeJ9q1KWNX8IIiUzVwbs/I55kqpYuVVcwXjFsjjpUZXWaCpM/Z11AGd1LFkzDf9SvwSOmrFJzyq4JlWX3Qc3Ry4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r3rKuG+x; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-4091180d3e5so3378208b6e.0
        for <linux-acpi@vger.kernel.org>; Wed, 18 Jun 2025 08:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750260102; x=1750864902; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9AxwiK4VYo3D71UIHkicDqC7/83I7Lbnvvk8W3WY5b4=;
        b=r3rKuG+xt/6fjUipvT17u93EVUlVMjQfpT7D05ucLAMebOFy9CQU5VMPaRb0oi7TqG
         ObTwduvkwcmOdPoXYIZ7v00uhzdYrqBkS7gPWCG7HUEgSePqKFIyPD6bfYossU3Uiy8h
         Ym/CawwMPi5XR2Fes6RHUXQGdzg7znAYpWbsEvvxibHpwhVgmD6+irjzgWqp45gVRzko
         +ATEuaEd231fsiA5Taog/NIImPA9KgXcl0O7UhCVqPTjjW1IvyGS88dp8pd4S2gQBMLK
         Pnl7CbNM3RSZ2EHZsVoSM8/wbuWl+tmm414+raqdpIV3s4CsLhJzvlrNRfzSLyNj6bJa
         DUxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750260102; x=1750864902;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9AxwiK4VYo3D71UIHkicDqC7/83I7Lbnvvk8W3WY5b4=;
        b=O2QjmRKNaAhZxXu/IKXS7SmI83KxXmAWXx0ZOwuCoqVjJyayJMT9Ta5jSieNgo7DVE
         kxkENrvkafkXFOlFtD4BLhL2MiYtF8SMcfdWnD80FrElM985V3odEVj/bsFUx9aYgp2x
         XJX6ksZ4iuM83TIyNtIfeYVYWo8dLKvJnSvsjU6jZT213VrlmoSE2xWOlUHcvnLU7HHV
         +O8vZyXfFTAQH0yY2G8gsk/Sh29+qhttMwdkUKAmXK9P3kgynBi+FDoUoZ0JnjwCBk/e
         U9VwH5WxrIgUGNUfpoxHucuhWO/JMjwQRJ1IS6fkAr0dkyLFt/g8hKZmcuJu0O/cOuq0
         7d8g==
X-Forwarded-Encrypted: i=1; AJvYcCXxKo8xSjjCAoG7Hw1vgyKzUsIZlB+8TOw6JZWQyfkS6TpGed8uxUCwzZL0uSkqGp5HIzCbg35ejZr2@vger.kernel.org
X-Gm-Message-State: AOJu0YxdHKFFzi0tuDoRYM0/O92/sYwSNglS1RG3SnC7zfCjTIos0opZ
	Fz0Om+SG19j2LssUjo4Wy6ZgksAonMPzcuVILX7w18lwv4s/fbR1gJyXnF45zsADMgs=
X-Gm-Gg: ASbGncs/0NViadH11BbycQJcvgN+tN/KSZP5tpdYDBIt2+InPRcT0H1rXD5O3IjhW4S
	bMY22B4SXihem09x8x+UNTtYuWqL9z+hEHIll9SS83jZzj4I5Strm9SC17qlBERGecpmbIVVgLz
	NlbzFMqGsQK1Cxg8CK+mbtIrgxNqnzEsL7bnH0ABcLeY76j0UQN4oXL3jzotPcwcs2/+j368tHm
	dOGVPIKeUSXQHK9BgbMy4QGz+I9qTNC6iP+7My8AK0dhrg2Z770ule+gIvlAbsuy+QXDVlVQ29g
	AaaIJS7Eh8N+Qzjhgf9rX76yKRkqOgMHOL83YyRah+XvCa/HhnFjiIgvnPFa3KHyRoQExw==
X-Google-Smtp-Source: AGHT+IGrf/owYOZYoHFe51D4S6Sh3ECbMUim7WjOpYzkcX3/wGxlPvEhosTHB9TtV8xPJwEvEZoZLA==
X-Received: by 2002:a05:6808:238a:b0:3f6:a1f8:ce3 with SMTP id 5614622812f47-40a7c1160b3mr10691931b6e.14.1750260102438;
        Wed, 18 Jun 2025 08:21:42 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:1b3b:c162:aefa:da1b])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40a741b8588sm2371576b6e.49.2025.06.18.08.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 08:21:40 -0700 (PDT)
Date: Wed, 18 Jun 2025 18:21:39 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Zaid Alali <zaidal@os.amperecomputing.com>
Cc: rafael@kernel.org, lenb@kernel.org, james.morse@arm.com,
	tony.luck@intel.com, bp@alien8.de, kees@kernel.org,
	gustavoars@kernel.org, Jonathan.Cameron@huawei.com,
	sudeep.holla@arm.com, jonathanh@nvidia.com,
	u.kleine-koenig@baylibre.com, viro@zeniv.linux.org.uk,
	ira.weiny@intel.com, alison.schofield@intel.com,
	dan.j.williams@intel.com, gregkh@linuxfoundation.org,
	peterz@infradead.org, dave.jiang@intel.com,
	Benjamin.Cheatham@amd.com, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v9 5/7] ACPI: APEI: EINJ: Create debugfs files to enter
 device id and syndrome
Message-ID: <3a143d53-8731-4afc-9117-bac49ea96db1@suswa.mountain>
References: <20250612231327.84360-1-zaidal@os.amperecomputing.com>
 <20250612231327.84360-6-zaidal@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250612231327.84360-6-zaidal@os.amperecomputing.com>

On Thu, Jun 12, 2025 at 04:13:25PM -0700, Zaid Alali wrote:
> +static ssize_t u128_read(struct file *f, char __user *buf, size_t count, loff_t *off)
> +{
> +	char output[2 * COMPONENT_LEN + 1];
> +	u8 *data = f->f_inode->i_private;
> +	int i;
> +
> +	if (*off >= sizeof(output))
> +		return 0;

No need for this check.  simple_read_from_buffer() will do the
right thing.

regards,
dan carpenter

> +
> +	for (i = 0; i < COMPONENT_LEN; i++)
> +		sprintf(output + 2 * i, "%.02x", data[COMPONENT_LEN - i - 1]);
> +	output[2 * COMPONENT_LEN] = '\n';
> +
> +	return simple_read_from_buffer(buf, count, off, output, sizeof(output));
> +}


