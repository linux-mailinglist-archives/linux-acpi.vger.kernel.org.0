Return-Path: <linux-acpi+bounces-21333-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +AQXGa5pqGl3uQAAu9opvQ
	(envelope-from <linux-acpi+bounces-21333-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 04 Mar 2026 18:19:42 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0D7205100
	for <lists+linux-acpi@lfdr.de>; Wed, 04 Mar 2026 18:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6B4C30C443E
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Mar 2026 17:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1690C37A4B7;
	Wed,  4 Mar 2026 17:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="g7jcjjMW"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C49377568
	for <linux-acpi@vger.kernel.org>; Wed,  4 Mar 2026 17:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772644566; cv=none; b=PtPN+tXtj8i7USEHDM/UIkyXFxoWCLknBra/PJOVMT9D+2LatWIBDadOfeAStsmmMbSFzygMKfeKaBlGUSX474qj4m8LpDRO2vAfSCAMkTRqKyojCx4vNKX2k0TH1zua1Re4NNMVbOYxjBocRb4KLkv8pp+pDTJFu8xm4KIRCk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772644566; c=relaxed/simple;
	bh=tcgxSU38eCGKe9JKypqd0oWkYktTm4f5HZFniG2DFiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W1Ie6RwklxVQnfkBzITVWo7otNVLTHbwbwN8DaP8AQo0ck3HsR6K7TvEXKDcIhXZpugsomMFpm02ub/XdgIZgKitYLKvfLCG9QWnIX3udjt5+WZgbdiISAs4ZsTSqaEG0wngMjbzkaZmG3dpJomK1sZikP6qk/drZh9EL13KWAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=g7jcjjMW; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8cb40277a8bso741560785a.1
        for <linux-acpi@vger.kernel.org>; Wed, 04 Mar 2026 09:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1772644563; x=1773249363; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tgdgDV2UNN/IZvvLYsVpz8+nq13Nj0KqwySIzPBQZ1Y=;
        b=g7jcjjMWKF3oD/ALftkhlaLG0ZGsLUXezJ7C+Z2hfmOxu2XD4wraFktqQgheD2xD3H
         b1HZe6fFQW8niJiBY2PjWXMiKb9sPnfsbMHk9VOEcmtwiXRL9Hq0n4oOlGuWmNvu2c8r
         HukbQPec0cDCWM/rTtxyoEupYWB6YZXCvzfTNK/JI3yExUax0Zs+RKkKyLS7kck3Xz4x
         m+cmrwPybgyeLuhjvWhwLhq3YA/l/g4eWkdQXKelZ7MUETxeKJLp15rzh9iiNlf+2dt1
         9bFsG6cS1XZZxkLCm2WVHugiQZUBNjCI+gHKNYrjVVzCDQVxCzDEtwVo+MrN/3r4VLoC
         tmZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772644563; x=1773249363;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tgdgDV2UNN/IZvvLYsVpz8+nq13Nj0KqwySIzPBQZ1Y=;
        b=owyeBujDY2hSYeZhicE416eQZu7ID4UUygvw8WRP8xeQuEHiuE9aamD2HpGi9omx+4
         wJluDtN+xKsBMP07u2eeWGVJQV7AjaPtgj1rjSLZr8X/KIRFNpOaEbtmzHMm4ovXzDhu
         LzH1X0uh7UgG8KtMoEhFB3HnlgKSmZ5FKEOz+Td/npTrQVQwECQnW773ljI718DduwDi
         AbafHXdgc3sTY3iMSArfsr3OD+BQRpB4S5s9niYpatNLl/o251SGH7WBthqunvz7Od/C
         75Fbm6WUYrn22JylbDsupKVg8TylAOcq+81RAn4V8xLwx8gnENxjODmdVbfhOQnMRMgW
         1CFg==
X-Forwarded-Encrypted: i=1; AJvYcCUdQfsyBqoSZD/kJiSDGJZBXe+Z/BDnQ70mtyeNQKo4Lrmxaw+u4+7PpKvOCCl69HKBANEjmCXsU1Dm@vger.kernel.org
X-Gm-Message-State: AOJu0YyaxRTyNalU+WN9TWY2ePhJWWfahNNO5gnJ1bs9lUHcJ9ICT1eE
	WnyfLnXjO+kLhO9SDb15GGoZ+xzljceK0uDjMDFqj+whp2D9r8YF4t6B6l+woYkM1sg=
X-Gm-Gg: ATEYQzwrvA+1u5K7x08PW7gvzAMNpJq5GVkzlwgjVxb/yNdFOd04/Ib2hVh4gzpi/GN
	0PkRI1MGfs5Fqx5pel0iLdgzVy7NxApOOeJEeOZh8XK6W88DrEV7NcTAE19P8MLJI6uGXG2edoS
	KR1BC/FpAbL1QJ91KPhG0mtiUQ4YYEE+ZG/zxpVLSzNRNBAur62lrraKE3bW9o9cTw7oFAGzqlV
	qvrHsEqkUH+VAm3AL04KsNbGwN5cv4bZf5MDYH+XSI3P3ChV+nA9uzp0pLuBYbolmb5aozQVsD1
	4rk53BDTVNnMbb9Byr6XFw0Sq4y35tkzgopxHRQuhiWzVtoq/l1qjP/Iw0QuOZbQ/7qt6PvKRgl
	76MVvTLP2MOxEIQC7WsoZ/1JkWp9fN76lOb70e8m5UD8L2A/WLP7SR9nLIkUkzvfu+fJmBPqgjS
	ep/Tztgain/E6nr2YbJkqw4DxxrmC1KquSgUm05co0bE+ity8Fp6ncs0i09N0ljindtysGXBmMc
	4fA/lbjag==
X-Received: by 2002:a05:620a:3195:b0:8c9:fb0e:ca43 with SMTP id af79cd13be357-8cd5af1a395mr339023785a.24.1772644563186;
        Wed, 04 Mar 2026 09:16:03 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf678156sm1865798585a.18.2026.03.04.09.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 09:16:02 -0800 (PST)
Date: Wed, 4 Mar 2026 12:16:00 -0500
From: Gregory Price <gourry@gourry.net>
To: Haifeng Xu <haifeng.xu@shopee.com>
Cc: rafael@kernel.org, lenb@kernel.org, dan.j.williams@intel.com,
	jonathan.cameron@huawei.com, dave@stgolabs.net,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI: add a boot parameter to disable parsing CFMWS
 during NUMA init
Message-ID: <aaho0IyQ0WAjcRMM@gourry-fedora-PF4VCD3F>
References: <20260304080647.169434-1-haifeng.xu@shopee.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304080647.169434-1-haifeng.xu@shopee.com>
X-Rspamd-Queue-Id: BD0D7205100
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gourry.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[gourry.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21333-lists,linux-acpi=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gourry.net:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gourry@gourry.net,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,gourry.net:dkim]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 04:06:47PM +0800, Haifeng Xu wrote:
> For the machine Intel(R) Xeon(R) 6746E that supports CXL memory,
> the possible nodes are 20 (0-19). However, only two numa nodes (0-1)
> have memory and the rest nodes (2-19) detected by CEDT are memoryless.
> 
> The problems is that when creating many pods, the shrinker map size
> needs to be expanded for all memory cgroups in expand_shrinker_info().
> If the number of possible nodes is too large, the holding time of
> shrinker lock grows significantly.
> 
> In this case, there is no CXL memory inserted in the machine, those
> memoryless nodes are useless for us, so there is no need to set them
> in 'numa_nodes_parsed'. After disabling parsing CFMWS, the pod creation
> time is reduced from over 10 minutes to approximately 150 seconds in
> our internal test.
> 

This seems like the wrong scope to fix the underlying problem - which is
the shrinker lock holding scope.

If you're not actually using CXL, can't you just disable CXL in the
BIOS?  Then you shouldn't even emit CFMWS at all.

~Gregory

