Return-Path: <linux-acpi+bounces-20182-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E56D11895
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Jan 2026 10:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F0A68300A1F3
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Jan 2026 09:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274D1342CAE;
	Mon, 12 Jan 2026 09:40:01 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ot1-f68.google.com (mail-ot1-f68.google.com [209.85.210.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CB1330B3E
	for <linux-acpi@vger.kernel.org>; Mon, 12 Jan 2026 09:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768210801; cv=none; b=r1Z+lLzTGU54IwxsXc3HgTpAWFa0xocwivjTKyits8F2hwxGYeQUoCecNuofNvsirqr3cOqj8zbl27W3acxukvSzkYlNswI1LFAWeGbqYcCrlQ/DkYN73UY9+2tC7Mamcg6ssnAzK7BgjPEL/0trMQD3dcUQDNF7TrQpD2HwWwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768210801; c=relaxed/simple;
	bh=e3qcK8+KKebtKO05qss+ntAP3vO1dLnBJMTKHLrT5qo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NuaTZkA3aoUiGTCaE7gAqS97OQkZ3Yy3qaPRSXSWIZW5rmIkc/Cz00w8wBd1AZpfqhO6PqhSROhqGtjiOoHI+W5+cpAXiIj1dBLPmUDVT5cvHcrDWBwT7j8/nN0O7bfYsEdSH7ECISa1j4lbwfc8E5bq5FFQaljU+p5zb/FnWbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f68.google.com with SMTP id 46e09a7af769-7c6dbdaced8so5171520a34.1
        for <linux-acpi@vger.kernel.org>; Mon, 12 Jan 2026 01:39:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768210799; x=1768815599;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8uz8Xl07/+Wj9gpiihBV+atTuU9+PiQ13eQaQwbHumM=;
        b=oh2Zs06TZpETBJGO+3J4g8NzVMgXhI72U1Fii11nnyAs3QskF8LW7oKaGwvGDh9IDF
         kuUn+2DEWoAJceRLdA4/+Pv85DD7dL6UoJ5fbH6HJCQ7IhbeHTt0tYgcgyiBfxqskSQy
         6ByvsK5C/qjgyunEbRqJQ7lq9Yka7xK8N84BdLxdsTt4q1qVUPZqcPJqDre4+vr+uRdJ
         KCae3woP2gVctlhcCaEmPBUbbngI6DG5Invw27Zpkay94rS8q8GYAF6T9wCo2TDHqgHJ
         fJMi5flS3OR58Szgj3wdzAbPCd3VSRjOVmWvj2+K2x59zwcg1KSRDe8Y0eo1gnzOOiMl
         537Q==
X-Forwarded-Encrypted: i=1; AJvYcCW4Ag4mRTL+c/vWFHSfM648nv4BxR74oH565kdA4spyUEzx4FvEnQNmF7E+bpuYnD6mPwWRxjaPSEKE@vger.kernel.org
X-Gm-Message-State: AOJu0YyUBtZ9MRTBvndbpeP0Clcz1zthgP8nn26tL6DIxAl8thvIc9Fq
	9GB4R3cGtLjM5D4LgELDIDnacuNURydTVmb12KLGqKv4fkbPAuEXsiUO
X-Gm-Gg: AY/fxX4EDwcgWwd1lrYk6zK6q0e+InT+B+UnqwjkmxcC3nPl52ySdyFmZ7G4iAjF7mh
	0oDy1y+9BH14Kp0ijCfZk8NrH1R8lQy1uRSMxUaX7nHt09ahV23/EJIrJ5KaPNNn8xDRUtaF9D0
	jalWlGaAWfeo2RnKYRwmgSnWC118juF1QFP3l/kp+SEkDtI1j+qocaucVqQtHTT4eUcLJxypUcq
	qTsYHqgdE5YD4geO1U270/EfYb1e6HQFTBCmVn8ikI/vlvAjbroRivbJDYlWFhXD16aQ8phyhe1
	WLtVU1N9IomTUVuX7wgdAEdZOoE8YXhsaw3bDoKv3GSkZxOSQo30aukcUp96lBsLAHuaB6eO8e6
	9+7u54z240nN81fZaYtlPXCyhNVI5sVMl5UJAmoRjst0lphNbGFFuzPjawGZporh4BRMdx+Oo4y
	NMGQ==
X-Google-Smtp-Source: AGHT+IHpYFvZuFRgkmQPxoEG91apjtI2xbke/iWdx8z+w6RLHRH/SmQgh8nYbaWNlS47LkFyTjqwCg==
X-Received: by 2002:a05:6830:45a3:b0:741:a5f0:bc82 with SMTP id 46e09a7af769-7ce50a2a811mr7762438a34.17.1768210798727;
        Mon, 12 Jan 2026 01:39:58 -0800 (PST)
Received: from gmail.com ([2a03:2880:10ff:74::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ce47832780sm12662190a34.12.2026.01.12.01.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 01:39:58 -0800 (PST)
Date: Mon, 12 Jan 2026 01:39:56 -0800
From: Breno Leitao <leitao@debian.org>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: tony.luck@intel.com, guohanjun@huawei.com, mchehab@kernel.org, 
	dolinux.peng@gmail.com, yazen.ghannam@amd.com, rafael@kernel.org, dave.jiang@intel.com, 
	Smita.KoralahalliChannabasappa@amd.com, pengdonglin@xiaomi.com, baolin.wang@linux.alibaba.com, 
	benjamin.cheatham@amd.com, bp@alien8.de, dan.j.williams@intel.com, james.morse@arm.com, 
	lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	zhuo.song@linux.alibaba.com
Subject: Re: [PATCH v3 2/3] ACPI: APEI: GHES: Extract helper functions for
 error status handling
Message-ID: <7yvemd3p7vxqxey5fcd45gth5dnplkgyoupkfji5pt5p4dfuvi@ult7tm6sys36>
References: <20260112032239.30023-1-xueshuai@linux.alibaba.com>
 <20260112032239.30023-3-xueshuai@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260112032239.30023-3-xueshuai@linux.alibaba.com>

On Mon, Jan 12, 2026 at 11:22:38AM +0800, Shuai Xue wrote:
> Refactors the GHES driver by extracting common functionality into
> reusable helper functions:
> 
> 1. ghes_has_active_errors() - Checks if any error sources in a given list
>    have active errors
> 2. ghes_map_error_status() - Maps error status address to virtual address
> 3. ghes_unmap_error_status() - Unmaps error status virtual address
> 4. Use `guard(rcu)()` instead of explicit `rcu_read_lock()`/`rcu_read_unlock()`.
> 
> These helpers eliminate code duplication in the NMI path and prepare for
> similar usage in the SEA path in a subsequent patch.
> 
> No functional change intended.
> 
> Tested-by: Tony Luck <tony.luck@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>

Reviewed-by: Breno Leitao <leitao@debian.org>

