Return-Path: <linux-acpi+bounces-13835-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4285ABE34F
	for <lists+linux-acpi@lfdr.de>; Tue, 20 May 2025 21:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA36E7B0294
	for <lists+linux-acpi@lfdr.de>; Tue, 20 May 2025 18:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AACA92820B9;
	Tue, 20 May 2025 19:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hzJ7L1ia"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D272925745F;
	Tue, 20 May 2025 19:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747767609; cv=none; b=Ap3eSr+TMz4IYEbnB0Oq7Qs6xiANSZ06DOejMESccNqBL/f6pd6yjLzWXJKpMhKcZlthBD6Pqb467gJcDXF5XvretIf1tN5B1bn1YC0vJW2GqTm7DEVf3TesLNbv/t8gzo/FKOJeUAVT29d0DDuUqwhETGrpHOvza4qYffTGTXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747767609; c=relaxed/simple;
	bh=HZcbWAnDrzpvnH9G0Q9jaOv82qQp+Qmcrd0rTVFy8i4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YS6ZxpCXWUhzwdX6DZDD3w+yzhR0CI+1eRO0e0j0S5uyQj3juiPj93o+DeQDncuD1fifTmANAdwb/bis4SdFHlud5ZcrGYnZ9dHOuFLAj6JesgtLlRCErc9k7MMWC+9zjsUWEl1b/7jkKrjQGkgx12jlXcwDv4cuh5OpBVgy0lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hzJ7L1ia; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-7086dcab64bso56051857b3.1;
        Tue, 20 May 2025 12:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747767607; x=1748372407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nir6kkeRUNYnE5nlG8GRhALN4HusH3tor7I7uLCCtVE=;
        b=hzJ7L1iaY41hO+AdkpY1P5TkExG55ZofZhNMAdHxOzI6ATNwkd1ijJH+7K5HukilFm
         30A8lPyYRDRsslqIVrLnvJAPLPZ4pIC9gLm2f0Jc3VBbnK6IsIVdAGSpmuI0BKiLu5UF
         QjJu2EMqRryFVkTGN+0T67nV96slxUYiGKWZgOcBhSQgUP07O950hmFOiHI1lhfgYm3l
         wC2CZSH1c+kHMWCwk+eFahdcRYDwvKDAWsvSGMar4ZZMN061PYF8AaaZrRwY271e8w+o
         N/qzd9K+TNfrZLdW1DfZCpcFhaOVWEVzEQe+WADbkxxE1iKk55X3MfQ7k+BFK7cD4Uq5
         AW/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747767607; x=1748372407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nir6kkeRUNYnE5nlG8GRhALN4HusH3tor7I7uLCCtVE=;
        b=LUsp7vHnTcsO2b76v+jEkJGdiXObLH/+bEHmj4XQ3G9UA4cS355tLNWVqv5M5+Dl1d
         sinPmIpo9WsWb4J5PxflJFd9X3P65rRME0ev/jM29HqZRVLxsiwQs7g/85bp4BHvdfne
         EbH3iK/5TUj4zVF3o1WIqQTmgjSfidd2srVBMelh25KLYIosmqBS+ariin/68EJjF3Wd
         jgDS1PwntklFFssl+puKoiqNbJL24f13Nx/J1HlkOQuLc83RUEMh+kS3+2M2Rzwz9/iP
         GjRKng3tLYRUIepLcOQuT1qEJs5J8a49ZpiCs+iVVnWWs+p+MTbvs8U/g67SJLNVyzzw
         babg==
X-Forwarded-Encrypted: i=1; AJvYcCVNTVAam2cdMisaN0E+Gb5sexOl/Ela8eRAj+xqRL++Su1B9chvGEkKAEWTW134QMLbAsuRCeFQ7O6D@vger.kernel.org, AJvYcCVTthWLecnc5kuAkMtbIXTw+yzFDTefWG8jvpJyR6g1OQWvEHm6Ftvqmho+Gjh3ysPfSpLF3shB9vRlXee6@vger.kernel.org
X-Gm-Message-State: AOJu0YwVCHC9/LuJpjYzUlsRkQebeFzgQJ4IgXadY9AUrP2gDO+wqtgk
	5sWcGyneWoWDZ3xYtJ/2S/gsiVAAzUQolJ6w/YYfVfBnlWaJQqv3nbyY
X-Gm-Gg: ASbGnctUMz2moJ0XBqw+tyZxCHW8oonjN8SC9qYG+Kfz5q2SnrcFb55G+YFxiLyUIez
	JFs0yGCkReNm/ZiimypDC1hy/Ab4WkzftO9pEH/+n7QT8ZxNde9Us9fmJZAmRsgadhHjC6qV0qY
	vqXMC6m4KigLkzzrIfK3oituS0a/BUXt1vh4xHHns6bXpvGgHriQ8GAya3lJD/G9tPO8NZY0tsb
	oAOOhPdxrbxHUij15zvTQb8e/4e0THzQlU1ubEw4a6JCa1k4I8qzC9Kv2WhFjfqyn/Nu9sl0eG5
	3OYveruGKJizbXBx+EYpFUxWkLtZKVkxCGove788pSNroR5ccJ8=
X-Google-Smtp-Source: AGHT+IHxf+Oh/vGp6cBjqEcIC0Qws0kB/8+qRetQYgkKEknE0CQAtz1R6fSe3QJttyS8pBn/KKYwBg==
X-Received: by 2002:a05:690c:9a0a:b0:70d:ecdd:9bd3 with SMTP id 00721157ae682-70decdda059mr27302927b3.27.1747767606598;
        Tue, 20 May 2025 12:00:06 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:70::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-70ca852db7esm23412547b3.101.2025.05.20.12.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 12:00:06 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: gourry@gourry.net,
	harry.yoo@oracle.com,
	ying.huang@linux.alibaba.com,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com,
	gregkh@linuxfoundation.org,
	rakie.kim@sk.com,
	rafael@kernel.org,
	lenb@kernel.org,
	dan.j.williams@intel.com,
	Jonathan.Cameron@huawei.com,
	dave.jiang@intel.com,
	horen.chuang@linux.dev,
	hannes@cmpxchg.org,
	osalvador@suse.de,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-mm@kvack.org,
	kernel-team@meta.com
Subject: Re: [PATCH v9] mm/mempolicy: Weighted Interleave Auto-tuning
Date: Tue, 20 May 2025 12:00:03 -0700
Message-ID: <20250520190004.274765-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250520113713.9b28c705b421c8bd3a51ac45@linux-foundation.org>
References: 
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 20 May 2025 11:37:13 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:

> On Tue, 20 May 2025 11:11:24 -0700 Joshua Hahn <joshua.hahnjy@gmail.com> wrote:
> 
> > > Honggyu's Reviewed-by is the only change I'm seeing between v8 and v9,
> > > which is unexpected?
> > > 
> > 
> > Hello Andrew,
> > 
> > The code cleanups & wordsmithing were part of the fixlets that I submitted,
> > so if you are diffing against the version of v8 with the fixlets already in,
> > all you should see as diffs are Honggyu's review and test tag, as well as
> > Ying's review tag.
> > 
> > I was not very familiar with the fixlet process, so I imagined that I needed
> > so submit a new fixlet to add the 3 tags. If that is not the case (and you
> > can just change the tags without adding a new fixlet) perhaps we can keep
> > v8, just with the additional tags so we can keep the patch in the unstable
> > branch?
> 
> Yes, while the patch is in mm-unstable I frequently update changelogs as
> acks come in, as people provide testing results etc etc.

Ah I see, sorry for the confusion in that case. Then I think all that should
change is to add Honggyu's review / tested-by tags to the changelog:

 Co-developed-by: Gregory Price <gourry@gourry.net>
 Signed-off-by: Gregory Price <gourry@gourry.net>
 Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
 Suggested-by: Yunjeong Mun <yunjeong.mun@sk.com>
 Suggested-by: Oscar Salvador <osalvador@suse.de>
 Suggested-by: Ying Huang <ying.huang@linux.alibaba.com>
 Suggested-by: Harry Yoo <harry.yoo@oracle.com>
 Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
 Reviewed-by: Huang Ying <ying.huang@linux.alibaba.com>
+Reviewed-by: Honggyu Kim <honggyu.kim@sk.com>
+Tested-by: Honggyu Kim <honggyu.kim@sk.com>

Thank you for your help as always, have a great day!
Joshua

