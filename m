Return-Path: <linux-acpi+bounces-7127-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA8E941676
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Jul 2024 18:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E917283FF0
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Jul 2024 16:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82DA61BE862;
	Tue, 30 Jul 2024 16:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="nyuzWyqJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909431BE84B
	for <linux-acpi@vger.kernel.org>; Tue, 30 Jul 2024 16:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722355219; cv=none; b=fcydYytNY0U9kpc+XcQ7mdwDqsvuzfJ0Hr/B5pJ0lCBHd7Z3E6zJjbgG9PsPhPxaBV0YZu2Fdg/So31drNpfRuWylbNzthdW4obbqlIDkMydEhSTK3BV9EG+I4gO9jyzdSP2CXWmyssUz7CQWSS5dyAGo2+oN9yL9MBjC3k4BEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722355219; c=relaxed/simple;
	bh=mCh601FrRtPxjpmD6wTsae7FGFqTSFvvavFvDhd9LnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V/i6U5en8hcQVO7pjpbInxOhJy8rwyMmNyiJj/fpRF9ZqCY9lkco+yFHFeQNKvHe31hbd7gpW80iYevF8yNqwhCXpXALDAZzf1ZsB2D5p3h811yMsh8yY0pXB6jQxC0DfGIqxykBaTKhfPlsBKX12CHhPz7oLNQbkOX/JOLsB0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=nyuzWyqJ; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-81ff6a80cbbso1316385241.1
        for <linux-acpi@vger.kernel.org>; Tue, 30 Jul 2024 09:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1722355216; x=1722960016; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ebSu3UElL8dKrK505UtfSRAh4jbtzC8DMHGUOIQGm/A=;
        b=nyuzWyqJID1+9n4yHSdJ8yP0dcTZQrXCr+yT6oD2PBfMFklD2z9JCBubRwnGxCZC93
         FlOqMi0PMh6oZvMH/40Ul7+kzE5yB0jws7Nuk1fySJEAwpzG5wmbIzM8DR+wU8edIGPJ
         6c2fcej1jARgTQ0hcZI6H/Fil1nNsJlqN+lG2zeH065UtJ9WWA7FBaBJxV8iYIiAJ/cV
         hZOnK3UmgKTF6Blban3ZvcWHcdWNMock4tNMzUMFlo7Dia0/D9BRDEZA5Uks4kIAhl5Z
         eerUqmd5Twu2HVfNXVXDXRUmw+VjlXtooIYHzX1E8Cln7cXA7+XpAf2aoAhJ8/0AP8/Q
         ActQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722355216; x=1722960016;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ebSu3UElL8dKrK505UtfSRAh4jbtzC8DMHGUOIQGm/A=;
        b=hnu5a3xlxDMy4IBxyq10ICsDvwmZgTp7fYEzjqG31AMg+7dKLVdJMmraOp/TpBtb/n
         YwX/AhmqUDTh1XyuYtUIPwSCwB0uyKB0yE+3dy4BeCQQMUKcQMm4RGJOhgejOVYdxUn9
         QFcyxH55zKVHtGUWLoQD+HEzk3FE2GKJUz82ZCjD+yEjwnsg2zKZIP6bEjmRMlKLlnJs
         wMfItkWNZMU1rF3n/npz8Gt+uEPDtrbulFxoA/DRubJydptLOlBRP16Y3paO59HjeBgJ
         lXRxVGGsii3DbE/ejJ9QoMG3UoeWBUHxk1qY+GH8hl4+1PkXoys8qT6PBZx3BJBxtHwO
         1e5w==
X-Forwarded-Encrypted: i=1; AJvYcCWaNSqrKBqUyOPyQ3ncRSyki7b+L/8iehqk20mTs1M0olKxF8nIfveDZV8OjcSdpxj9WPkiZhWBSKGxxOqbKI3cPWBAahCameEDxA==
X-Gm-Message-State: AOJu0Ywu8/KO/4fCOjxKsMfM8W2wmX4HJ4i9u9diOZIZQFeUChsaQx1f
	oLddbuk18r8QVHwtUvcqJ5N/17MTH9xPYL4YsQyyH9OUUq/eF3XNxCG7GwiVOp0=
X-Google-Smtp-Source: AGHT+IG64oD/0BAxRTYSk9Um5ejrwHurtyJiWine+vs8I2db0quwR2iEnh/I3UfX946vZydcmQjuVg==
X-Received: by 2002:a05:6102:3ec2:b0:493:b2b4:3708 with SMTP id ada2fe7eead31-493fad54e1fmr12048280137.27.1722355216237;
        Tue, 30 Jul 2024 09:00:16 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1d73b2036sm653148085a.38.2024.07.30.09.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 09:00:15 -0700 (PDT)
Date: Tue, 30 Jul 2024 01:19:53 -0400
From: Gregory Price <gourry@gourry.net>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, dave.jiang@intel.com,
	Jonathan.Cameron@huawei.com, horenchuang@bytedance.com,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	dan.j.williams@intel.com, lenb@kernel.org,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH] acpi/hmat,mm/memtier: always register hmat adist
 calculation callback
Message-ID: <Zqh3-TWBkhyY5kPw@PC2K9PVX.TheFacebook.com>
References: <20240726215548.10653-1-gourry@gourry.net>
 <87ttg91046.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZqelvPwM2MIG26wY@PC2K9PVX.TheFacebook.com>
 <877cd3u1go.fsf@yhuang6-desk2.ccr.corp.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877cd3u1go.fsf@yhuang6-desk2.ccr.corp.intel.com>

On Tue, Jul 30, 2024 at 09:12:55AM +0800, Huang, Ying wrote:
> > Right now HMAT appears to be used prescriptively, this despite the fact
> > that there was a clear intent to separate CPU-nodes and non-CPU-nodes in
> > the memory-tier code. So this patch simply realizes this intent when the
> > hints are not very reasonable.
> 
> If HMAT isn't available, it's hard to put memory devices to
> appropriate memory tiers without other information.  In commit
> 992bf77591cb ("mm/demotion: add support for explicit memory tiers"),
> Aneesh pointed out that it doesn't work for his system to put
> non-CPU-nodes in lower tier.
> 

Per Aneesh in 992bf77591cb - The code explicitly states the intent is
to put non-CPU-nodes in a lower tier by default.


    The current implementation puts all nodes with CPU into the highest
    tier, and builds the tier hierarchy by establishing the per-node
    demotion targets based on the distances between nodes.

This is accurate for the current code


    The current tier initialization code always initializes each
    memory-only NUMA node into a lower tier.

This is *broken* for the currently upstream code.

This appears to be the result of the hmat adistance callback introduction
(though it may have been broken before that).

~Gregory

