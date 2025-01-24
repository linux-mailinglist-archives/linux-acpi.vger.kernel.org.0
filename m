Return-Path: <linux-acpi+bounces-10816-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7003A1B9B2
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Jan 2025 16:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 233DA164DC5
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Jan 2025 15:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79B7156879;
	Fri, 24 Jan 2025 15:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Rkkqgp1n"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2623915623A
	for <linux-acpi@vger.kernel.org>; Fri, 24 Jan 2025 15:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737734030; cv=none; b=p0BDAlkWpJvfIj/vBs38YSJIoVkbbvc4urukd0rBN0gaT39Y8xcUXbIMrOV+riT1VQ4vCYy3EBu8VaWwPlChZnSJuJLZkOjnD83hu/dYiHgyZlpz8KXHoCLVeMRib2pC57Avnh6mp+8DnzLUVnWv2+KNELwzfp2UpIfYx5ZrjrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737734030; c=relaxed/simple;
	bh=DEKjAD8V1b8lppa3dL4yHvR/da6RO33fHpI49jJmFXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l/4AQgOEqnSlFNjcFgP1MVZwQYcOMmBxahYrwod6LxRpBJm4Or9bqsvAWjK9KE/2DD+gmmAi008m6Bzu/zPpNFkiuxVQJIBvdcVEOlX7oC0zqwQ8t5db9dymiX4F/g6q7HBUYCDW2aC9SXQKB4QZVlSY6UaYZdBPXZRToqyILdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Rkkqgp1n; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7b9ad0e84e6so253860485a.0
        for <linux-acpi@vger.kernel.org>; Fri, 24 Jan 2025 07:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1737734028; x=1738338828; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QNbhaq2mDbHmLsVQccpi4ScY6Cq5iVtMLLZKxX9HEIQ=;
        b=Rkkqgp1n8P9Ig8fp5dPsAzNWlaDSvxGndx+xMT7MzBEUBCzlwReOLz+EsBP7lsdNqG
         NMsr4I2+j+XBAb9HWd8H3sradLFYwNKUvbhuSINobHRa920/RgreJQGp0oSuFyp/VZLt
         6UzDBa4WtBS4SDrlP+MhUv8+eExflanwnkpZd9FZXSKbCZj+fSAeOVM0zjdTHfUVK93m
         g7jAicO0XYz+SHMgAjYGrCqtc7+f80vuDC7VfYQY8ay/layFDeEFqhXXXaKjgWpV/T2F
         KLBZUUyzBADLxa13y7DLRPCQfPewy4GtUqurAaVatB6zOGJ6Nio+9+yEodCxAwf7m0oq
         2RbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737734028; x=1738338828;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QNbhaq2mDbHmLsVQccpi4ScY6Cq5iVtMLLZKxX9HEIQ=;
        b=bAz7yeZZ0sZIugWPQ98nVizO6QwBGYmpk6P3OcQO0wLDfHJydnbIR3J7dPmCnpInu4
         WaOlH4+La8VyVcTGo8LPzVOuBweD7CqY6flk0y5sypiMU+pI7SXpBkUsKQyJTSDzuFad
         JUtQJDcAuVVeEuMFUf3T08L2QnxVjtMpo9L9a0VKZVenpFiNfexdeMQf/RowOG3jkTac
         12vXI2+2WJelvSLzLmCu6ZWEy6uOgqKTt61+2VLGdbE9cW2SfgdopK4IXtErTEkjZ768
         hpJD4xRk5r4JtB+krF9UH1r1rr6P/dHSDhskkmuxnX0ch4usel4+CdiHvzx3Jt6aG/oG
         PEqA==
X-Forwarded-Encrypted: i=1; AJvYcCWCFjV6RYJCJue9iiF+xXb2rGeC4Cm08wbZgsbPOwxmmXQ15T53Q51E/IV45IxJFmqbsSoxgm5/kqIP@vger.kernel.org
X-Gm-Message-State: AOJu0YwrUuAh2zHZe9mtFOSxglqHUbZsWHFRKTsD4g5lXruSeCyCsG9t
	Di0+TdIy21tL9S7GIRPbqtjuClx9rlwiPIWs+/wl0P5tT/oqY7WBP/sexgtHGgo=
X-Gm-Gg: ASbGncvxMoXUV6LF34C3lvhrsP26kKDSVYCB3kXU5a2uzQgOpelhshECf5eBkVVHqiD
	Y+ag59n0PRvHvqHTH0et3GXzrrMJlSFDnY63QrOg9yjlZCUeenmXAh6x5VpjUBUXRu9sDZsRXD6
	+JhzbbAfFJsOch8INrTNI1HmbnAsMjBIbc21GI3rwZHs026TVxxyKWAsoguHJVRZqn2RQp53R+E
	YVem0O3n0nWVmWVubsEjcYBIFXr11t5+76oy28qnkb+ZEcv6S69WsXKgF+IeVd8MNGITQ+tdRNW
	SjcdHq2kyNXtBEzc7Lzp6X1VjBu3BnuCCUjRrgFLF8nzAC15JZ8hZXPkhaWAnDI=
X-Google-Smtp-Source: AGHT+IFTWiA+tThQLUYQm/V512P/UYDBb7llFCWkcCEMbCbinB1KbnHmt16PLYaWYOwlwSthaf9oAg==
X-Received: by 2002:a05:620a:2603:b0:7a9:aba6:d012 with SMTP id af79cd13be357-7be631f2e01mr4765020285a.22.1737734028053;
        Fri, 24 Jan 2025 07:53:48 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46e6689f720sm11388961cf.42.2025.01.24.07.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 07:53:47 -0800 (PST)
Date: Fri, 24 Jan 2025 10:53:45 -0500
From: Gregory Price <gourry@gourry.net>
To: Matthew Wilcox <willy@infradead.org>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>, hyeonggon.yoo@sk.com,
	ying.huang@linux.alibaba.com, rafael@kernel.org, lenb@kernel.org,
	gregkh@linuxfoundation.org, akpm@linux-foundation.org,
	honggyu.kim@sk.com, rakie.kim@sk.com, dan.j.williams@intel.com,
	Jonathan.Cameron@huawei.com, dave.jiang@intel.com,
	horen.chuang@linux.dev, hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-mm@kvack.org, kernel-team@meta.com
Subject: Re: [PATCH v3] Weighted interleave auto-tuning
Message-ID: <Z5O3ifDLUl4zlmtg@gourry-fedora-PF4VCD3F>
References: <20250115185854.1991771-1-joshua.hahnjy@gmail.com>
 <Z5Mr8WQGEZZjp9Uu@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5Mr8WQGEZZjp9Uu@casper.infradead.org>

On Fri, Jan 24, 2025 at 05:58:09AM +0000, Matthew Wilcox wrote:
> Putting page cache in the CXL seems like nonsense to me.  I can see it
> making sense to swap to CXL, or allocating anonymous memory for tasks
> with low priority on it.  But I just can't see the point of putting
> pagecache on CXL.

Also for what it's worth, I'm trying to get page cache *off* CXL
when it becomes warm/hot :]

https://lore.kernel.org/linux-mm/20250107000346.1338481-1-gourry@gourry.net/

~Gregory

