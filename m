Return-Path: <linux-acpi+bounces-10878-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4388AA24E84
	for <lists+linux-acpi@lfdr.de>; Sun,  2 Feb 2025 15:12:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5CF9161225
	for <lists+linux-acpi@lfdr.de>; Sun,  2 Feb 2025 14:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963821F8679;
	Sun,  2 Feb 2025 14:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="blxFU8kP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BD9E574;
	Sun,  2 Feb 2025 14:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738505573; cv=none; b=EPdVvk/b3zbHfuHMbHOEmM+93VfEwO2gHbvsODTYIvioiucjuq40wiWTl+L72kV8zKNlP9gUS0Za5ycfa+GcmrK1P21YR/Oy738GVU1y7y0nTmQRtGbf8Oq/xyhAAWzyqpjcnO8KSedSoucd2QXI8sTjxUZfOXou+RQp5IKwrRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738505573; c=relaxed/simple;
	bh=QZm1LtvGQKCijH7Ny3Z1lJ1iBrDQ8MzH8+nch80dCX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D5uU+q5sMIh2euxXut5Ow0zGpBRmYYY9Cr2tqcCo6ONlQTND7pmOkHHhmoMOT45gGwmfz3GKDpZjM4o/fSByYmwJYtv8tXQwPsjGD+oMx6tcAXHJjiw71jSKzWZKPyPlF5amYrn+aPZaCzoyRzINrEw1eCXA4lbct2a6vt5X9Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=blxFU8kP; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6f6715734d9so20157387b3.3;
        Sun, 02 Feb 2025 06:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738505571; x=1739110371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OP/ULsuhS2l/WjnpV3aP5975AuU0qKrgS7YueBktGqU=;
        b=blxFU8kPtZak4OPtl/vV3BSR96zDpWhjc3+Of9xOBUoXZRq6ryhWnHRBVlnEs/6qdM
         sX2jkfnYG0aOUqLZAlhF2+u1ADDSxWM4kMS5t75AUWqyqC35HljN2fzleqWbgDbjnNiA
         GR0JzN5miY2hm/tdfolHFMeKS55H5P6QmZndHiMFxJy+tf9VoZCoL4SlNm+rnm0EMzoE
         xrm8zPl4hKfbC06siLWEoZ+Qa/4xoz93ETDrcaB7TpYQWJbZOpI+LX0ajV+wwPK5/whg
         voFiPcS0OtU8zXiVORO0yWllfYvIpUg4/pI651ADe81a/deAg6uAA7c0nwDNYBDeWcrG
         b9oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738505571; x=1739110371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OP/ULsuhS2l/WjnpV3aP5975AuU0qKrgS7YueBktGqU=;
        b=ie6qFsVy7qFPyeUfiN84wKGmpduGmB+1g+GjcEo8xEIwzQf2LlWf0ErQdyEHJA5aeI
         k0ylzgaEcc1Squv77BPJTDSG/yflqMOxd7WfbWWXIq4MAJqw4H6ov6sMC5jrCSYcv9El
         x6DbcC0HNzrijv25SqmeZWsa6MEe+l68gWyebRZfUD/DEi1FShIKvTZxRVOydRGQVMGu
         QadzbJlr8ewzgvxy8QDWwzCFF/MpIAGPmrt59/MJ2H5LZAN7+phUSKsxPefOjc7Bc65p
         QSBZnGI2ThZxORfS+F3uusuXz/8RkRiX6+vLmwVK8/Xc6AUvYJxYhyaLX84ih6toYjvY
         bqSA==
X-Forwarded-Encrypted: i=1; AJvYcCW+9Le4ZoYT01g/JuoiYkTiYgBtjW6NGwnyXdsvowxWHvfg6JOeg+EH8M4iMjfrBqYVhQG9m6UBNzFYRqCm@vger.kernel.org, AJvYcCXsMKDeeTAxWNmexHR4hQpBJ5NlmhWivAardBrUUVpf42aicPE0yC7uDLMyS/Z0ewy4mpXTkBhp3Rpa@vger.kernel.org
X-Gm-Message-State: AOJu0YyHI/zYbaiOYVn5TbB/1cVFndaOBJWXVEtfEUZlYodRqu0rekyy
	I6vDzrG018Tp6Z9YZqCIeZNMjMnHv+37T54CVkKU/MaLiVzqFvo2
X-Gm-Gg: ASbGncvj3cPRw+tAVOA0rAG97m/5KzEsB7Y+Y+Oryvj4c7iYwyOMilkskJyh9I/viil
	F0IFC+8Marwph100JothFRoNwX5a2+SZLLXTn1IkvRLKKCj5zfmphS/Vd2lF21j6pnQ7hM5WE45
	yGQURbDPVOu6fE7bEqgyOHVlRDXx5J/a1Otgg8ENc017XCT207Ek4dGWdKb4OOhhyvMB6ei4w4V
	V5vxJSiKQWHEp4+AUucGQ6lXg2LNHa/fB6kVWendF+0SMXIktQp5bS4LfFp4EgAMzCp/U1Btaa9
	uuPMq5PtFKlIFg==
X-Google-Smtp-Source: AGHT+IFJs8bjsu60rsjFrfo0Bqk9SgH1Gw8S19VwGfxOIrB19mypYyxFGAIAa0MS1NyLIlbLgZr4Yw==
X-Received: by 2002:a05:690c:610a:b0:6f9:4413:3db8 with SMTP id 00721157ae682-6f944133f86mr38193097b3.0.1738505570824;
        Sun, 02 Feb 2025 06:12:50 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:1::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f8c46061fbsm17109507b3.17.2025.02.02.06.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2025 06:12:49 -0800 (PST)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Honggyu Kim <honggyu.km@gmail.com>
Cc: Gregory Price <gourry@gourry.net>,
	ying.huang@linux.alibaba.com,
	rafael@kernel.org,
	lenb@kernel.org,
	gregkh@linuxfoundation.org,
	akpm@linux-foundation.org,
	honggyu.kim@sk.com,
	rakie.kim@sk.com,
	dan.j.williams@intel.com,
	Jonathan.Cameron@huawei.com,
	dave.jiang@intel.com,
	horen.chuang@linux.dev,
	hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-mm@kvack.org,
	kernel-team@meta.com,
	kernel_team@skhynix.com,
	42.hyeyoo@gmail.com
Subject: Re: [PATCH v4] Weighted Interleave Auto-tuning
Date: Sun,  2 Feb 2025 06:12:45 -0800
Message-ID: <20250202141247.2219681-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <9edfb12f-5e1d-4de0-b124-37053125a7e0@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Honggyu,

On Sun, 2 Feb 2025 22:51:34 +0900 Honggyu Kim <honggyu.km@gmail.com> wrote:

> On 2/2/25 01:53, Gregory Price wrote:
> > On Sat, Feb 01, 2025 at 11:49:31AM -0500, Gregory Price wrote:
> >>>    1. the auto mode set the weights as 10:5:1 for node{0-2}.
> >>>    2. node2 is offlined, then recalculation makes it as 2:1 for node{0,1}.
> > 
> > Point of clarification here:  a hot-unplug event won't cause
> > recalculation.
> > 
> > What actually causes re-weight is hot-plug reporting new capacity.
> 
> So do you mean re-weight is done only when a new node is onlined while
> offline doesn't trigger re-weight?
> 
> I see node_set_perf_attrs() does recalculation by calling
> mempolicy_set_node_perf(), then reduce_interleave_weights().
> 
> But I'm not sure if the re-weight is done via node_set_perf_attrs() only
> when a new node is onlined.
> 
> Could you please explain where I can find it?

Just chiming in to add some clarification:
Your analysis above is correct; reduce_interleave_weights() is only
called in 2 spots: once when the mode is switched from manual --> auto,
and the other when new bandwidth data is available, which calls
node_set_perf_attrs() and so on. In all other scenarios, iw_table is
preserved, and all values inside remain the same without manual changes.

A node offlining (or even onlining with no new bandwidth information)
will just mean that the node inherits whatever value is stored in
iw_table at that moment, whether that contains the default values
created on init or the last values that it had taken. 

> > So in this scenario, the weight will remain the same for node2.
> 
> If it's true, my scenario is wrong.
> 
> Thanks,
> Honggyu
> 
> > 
> >>>    3. the auto sysfs interface is set to 0 to make it manual mode.

Please let me know if this makes sense. Thank you for your review
as always, and have a great day!
Joshua

