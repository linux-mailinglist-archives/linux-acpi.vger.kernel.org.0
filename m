Return-Path: <linux-acpi+bounces-10874-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF470A24ABE
	for <lists+linux-acpi@lfdr.de>; Sat,  1 Feb 2025 17:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C67F1884B58
	for <lists+linux-acpi@lfdr.de>; Sat,  1 Feb 2025 16:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4445F1C5F28;
	Sat,  1 Feb 2025 16:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="DcLupMks"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBF01C5F10
	for <linux-acpi@vger.kernel.org>; Sat,  1 Feb 2025 16:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738428579; cv=none; b=TItrv+ibPUdidqAaQQhKmVf6RiYD9ES1H525FmMQ8Ep1R0rOgRsOFXOz6XKwdSnIu454cd/Bj5RvbTwinQuAwGqeopel4dgogwDBCcbF2SmczgyRNWgBaexV+SXOb49uOuxPChoGRXtW55kWlxoyGntVbVHFwDekmTB3b+qRfQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738428579; c=relaxed/simple;
	bh=1C1vDfhGBCWdt2CIGwRL1PaM2A6eXIXmwjWafKPpw+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oh54RCgWV61YW5qD76ClHNs1OKLOS8R33AqsyEy93cgkg679dMHUpFXmNxLPqcdYdhWwiMDfOpds8bOzj2TyrAa/HQzMlqZmH6PwabpGh4K5w7j2LKiuSZwuavy2CSO16VWbQhtchmEmILN87X1KcKQYjokErFP7h+WBjACe92U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=DcLupMks; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6dd1b895541so61264406d6.0
        for <linux-acpi@vger.kernel.org>; Sat, 01 Feb 2025 08:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1738428576; x=1739033376; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i5hZ7n+KMI2jYGZGNxK3D06MIX9VxNA2G3c9z3NYvRk=;
        b=DcLupMksi1+JN6Mo8seQ/fo7GEqTast3yXT1S7Xa88UnTH1CvPc7cuREZsFd+PIsDB
         UAGczRPmsE8ggWxtWYhDkfJlUAwX+V3k5rQfZCcCfmzKqZ9EJSiHskdEXwdD20KoX3u6
         vnz8MIT69B8Y8svSqEle4zyinMg4yvVsE4bSvXoEaNIPbXOd6nFhXm5UUipqsU/luFU/
         dCyZlMZRTEXTcVnQWSw3UT2+qEdJ6wgz8ljvjtDpt2xigrDlkitIeEuhaTDTZKajxdix
         NDInTF/D2tu04K8YTwZamvljBcbUnGb9GgW6aftc7cSEx3hZWv3nng2ItGNw1rOqdXa3
         JmpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738428576; x=1739033376;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i5hZ7n+KMI2jYGZGNxK3D06MIX9VxNA2G3c9z3NYvRk=;
        b=LkJxqSsl1a0BPCta1LVtOwSc4oMxUT33KFjC35fJqISEeGVkbqpqmAL8makUbf/Q8a
         C5/ECB4Yvpz3WnA5JKCPLlcteu0wLWPaSsUyzF6HV82RmBQKzDxgmfY6Ha+qRaF8P7Ny
         PhI9DeQZdHTveB1TQPt84hLRczL02JZGTjXRpbLhPK7gWLc/bw7sq9YqtnAgHb/mZ+SM
         JwtOOrBYoGUDtmujDiRhedFYlE+Ys1qKUrJu0L8ohzIBWCdRpx5iF4eJ1ExpOvgq/kuP
         PgUXIFnj8uqOUNZyP8QoFSKES5xLv+x5mYlccXkPB0/ghepFM10kiX21oabeIE/9s8/T
         iaQA==
X-Forwarded-Encrypted: i=1; AJvYcCUPDMjG2YbJQeKVHqUg+4ZNHN7n1GHfTv27HLq/M6K/5nQ3ZEzNvHZLkdvzoKkMXzSbTwN7D2SGlWGo@vger.kernel.org
X-Gm-Message-State: AOJu0Yy52lf4yFIOgeA1Fui/fuTyWZwMHJcJt3aHP87f3E58v65rxXqZ
	0AWRwZVSsvP2YIGPwMnChmuMxjeIXHInNtxiHaLNv5lIT94tL1UKfxwe93wZfEI=
X-Gm-Gg: ASbGncsGxylm2l0yZOHT+RpcST5Sqz6ugKeGZHBf10HM8zVTAZ5nxspaqGV74NxKvrO
	HcWhN9abEhVueO2C+fm2jpAPCagElyGReB7fin+oMHZV3Ow101fakJ12RCneH9hLchIA9vSGint
	dWZQ/1GhihQIi22/YCjbS/A9FpZtDOalecg+g5Ul5S7oK8MxhLawUuOwhFcmxb6/rzF9Gz9+DRQ
	h8Vx6Oeepm6wLlfuqq2tIs2tfhiU4ZzomR2MAzhS7dkgg11KqgViuldpGcP9S7XPckxKMtxz3Aw
	+DKAkxgNWTKumbZKy2ztBB2GZ4g05bFMTwhHH1exeBZqrJVdISCe250AQ0jtk7LHJbqtRi9Akg=
	=
X-Google-Smtp-Source: AGHT+IGQ1+NLg4YrZ+Gf9BL0Rh9NpBsRqQq8Sh+36quBm0Fy/vRbGBngIjmOrObiKxMdofyyvxBbfg==
X-Received: by 2002:a05:6214:238f:b0:6dd:c594:27a2 with SMTP id 6a1803df08f44-6e243c07fc9mr257417916d6.27.1738428576442;
        Sat, 01 Feb 2025 08:49:36 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e25493ee7asm29729816d6.94.2025.02.01.08.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Feb 2025 08:49:36 -0800 (PST)
Date: Sat, 1 Feb 2025 11:49:31 -0500
From: Gregory Price <gourry@gourry.net>
To: Honggyu Kim <honggyu.km@gmail.com>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>, ying.huang@linux.alibaba.com,
	rafael@kernel.org, lenb@kernel.org, gregkh@linuxfoundation.org,
	akpm@linux-foundation.org, honggyu.kim@sk.com, rakie.kim@sk.com,
	dan.j.williams@intel.com, Jonathan.Cameron@huawei.com,
	dave.jiang@intel.com, horen.chuang@linux.dev, hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-mm@kvack.org, kernel-team@meta.com, kernel_team@skhynix.com,
	42.hyeyoo@gmail.com
Subject: Re: [PATCH v4] Weighted Interleave Auto-tuning
Message-ID: <Z55QmybX5IkuLv6Q@gourry-fedora-PF4VCD3F>
References: <20250128222332.3835931-1-joshua.hahnjy@gmail.com>
 <41ab5a11-f8d3-403c-9d68-33eb15aef8fa@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41ab5a11-f8d3-403c-9d68-33eb15aef8fa@gmail.com>

Hi Honggyu,

On Fri, Jan 31, 2025 at 11:23:34PM +0900, Honggyu Kim wrote:
> Sorry for jumping into this discussion a bit late, but IMHO, setting a
> newly onlined node's weight to 1 can possibly make the entire weight
> ratio unbalanced.
> 

This is only the default for either:
a) Manual Mode
b) Auto Mode - when HMAT/CDAT data is missing

In manual mode, the node weight in /sys/kernel/.../nodeN is present
regardless of the online/offline state of the node - so it can be
set prior to that node being hotplugged.  Since it's in manual mode,
it's expected the administrator knows when things are coming online
and offline, and they have a clear chance to change weights such that
a 1 is never perceived.

In auto mode, the node goes "online" after HMAT/CDAT data is reported
so users will generally not perceive this default weight.

>   1. the auto mode set the weights as 10:5:1 for node{0-2}.
>   2. node2 is offlined, then recalculation makes it as 2:1 for node{0,1}.
>   3. the auto sysfs interface is set to 0 to make it manual mode.

If the user sets manual mode, they get manual mode.  If they don't
want to manually adjust weights, don't set manual mode.

We can't stop users from doing silly things

~Gregory

