Return-Path: <linux-acpi+bounces-9073-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9512D9B4ACF
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Oct 2024 14:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F69F1F2192C
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Oct 2024 13:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1A4206044;
	Tue, 29 Oct 2024 13:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="SiRaQ6JE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D9F205AD4
	for <linux-acpi@vger.kernel.org>; Tue, 29 Oct 2024 13:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730208043; cv=none; b=gPI4ExU1ZoNEaHxuZWfTMAYTIdK+e8DqOre6XWR2SzBTq0I9SFQ3bfwhzftVFWayh9oiioXUtoiYa6zid9y0XcI9wH5zM0BYJnSF1rmPLzJQltL4nDTvdVTxWET8cA9uXh7Grg37c6mxy4TzmLM+x/fWmGblvdtMSSLdvBfeuxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730208043; c=relaxed/simple;
	bh=0Rw57/ngh3X2LN6V+OXc0GKTZffQMRd48D8zHGpjNug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SNVEfXcDLDfDBZIcIaTYUBE2gHo7oWDTKlD6ybmO526clGKJj7i4H+P768VrhlHbsE06XNZ9+ScD+a9fhrG8A2mPSrmxUf0xESD8Wb0WlH2q7Uwg7zECNlKGBEqkzgITvY+GX0eXDz47nqu7f2Q4n9kyfz0dfUptF9NRJHE117Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=SiRaQ6JE; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7b1467af9dbso435825385a.0
        for <linux-acpi@vger.kernel.org>; Tue, 29 Oct 2024 06:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1730208041; x=1730812841; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X13QuMz4ULWUYaYEjbvcdDk+axoVrdNmaWAMXcQKv4E=;
        b=SiRaQ6JEMQa6ZZ1yqx72cMKwyEPQNvBK/kz2f40yR1QZylStTnSujCAagyERp5HXgD
         IZ5v9tFgdHXNLxoXHlnDPLNudynqMC+cmcQAeuq7eYNb9caIoRO/CMLmsjD/AlVVcp+z
         +EOnS+87sybIe68R3tB3YP76YuafsKMHmyYwGHJzwSZzIj8Q0yMeIPr40C9ogssSCZDy
         sGnZQuCjj6b0Y78iY6BCcua1yZvj/CnPtrwfmEPGr0a/10l0qtSWQGIWlKu5832O83fo
         19GpJW6N28kfDy7opKFT0LDqb9QDTSB+A5/LBnmesUY/TgzckYq/biPTVRddTywFy+5a
         Nc2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730208041; x=1730812841;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X13QuMz4ULWUYaYEjbvcdDk+axoVrdNmaWAMXcQKv4E=;
        b=U4/gHHqZXIhvj6kJmBj+QkOz4lEdPqjqaAfUwVUUpYI6osEgEgWskHstpXfBBEveHR
         ZM5+T9dJ5PDlvhQ/oVIoBQoTJ5e3p3ektDr9Le211gwiwK+5KxMq4tqsKSi046CWvR1M
         0qb6Eie2LM4PIa4t11IRDB4tRVmtqS/oqYODMJoeRFyu+GL3v4C86npIj9h88MIIzsuV
         hGkAJKPJ7OX/c3Ir6ZLWmSAGW0K+PTD5qYKCVK3RVrWhDX/WwXv41T2+piJPXG0cgVhY
         cj7j3+lxTztblpY1U8pPXogHE74+pOU0QsgeGuZAIhmUFsKcloiMyj96Q9WvuLeri7BN
         jCww==
X-Forwarded-Encrypted: i=1; AJvYcCUOhA9T0qO446nh2JciQKBGIgqXDNbjXOlzy7wis3MJo4Cul8nBezootCzrzR/Z/dhQkSGEYqM+jX8E@vger.kernel.org
X-Gm-Message-State: AOJu0Yya6P0akN3bHwxO7IBLY/DtWsolU9TadAiKQcYKEni7jQtGgvRw
	C6ucFmZRT16mcCDLKDsSDP/kDSooiA7Xkp7/1v+hVxzk568nQdSKQ+D7mnE8GXc=
X-Google-Smtp-Source: AGHT+IHhg5v3TWiRx6aq9mSkPnfzEXY2e0MobJKbVOXNsfSKLR6G02+D9thPPmKmqRlxnYDQq09kuw==
X-Received: by 2002:a05:620a:1725:b0:7b1:4948:109f with SMTP id af79cd13be357-7b193f650abmr1528422385a.57.1730208040698;
        Tue, 29 Oct 2024 06:20:40 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b18d32c9e3sm413535685a.80.2024.10.29.06.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 06:20:40 -0700 (PDT)
Date: Tue, 29 Oct 2024 09:20:44 -0400
From: Gregory Price <gourry@gourry.net>
To: David Hildenbrand <david@redhat.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-mm@kvack.org, linux-cxl@kvack.org,
	Jonathan.Cameron@huawei.com, dan.j.williams@intel.com,
	rrichter@amd.com, Terry.Bowman@amd.com, dave.jiang@intel.com,
	ira.weiny@intel.com, alison.schofield@intel.com,
	dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
	rafael@kernel.org, lenb@kernel.org, osalvador@suse.de,
	gregkh@linuxfoundation.org, akpm@linux-foundation.org,
	rppt@kernel.org
Subject: Re: [PATCH v3 3/3] acpi,srat: give memory block size advice based on
 CFMWS alignment
Message-ID: <ZyDhLLCNXFN_M8l2@PC2K9PVX.TheFacebook.com>
References: <20241022213450.15041-1-gourry@gourry.net>
 <20241022213450.15041-4-gourry@gourry.net>
 <55a5b63a-a6bb-4ba0-9aad-c9d8741d1c3a@redhat.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55a5b63a-a6bb-4ba0-9aad-c9d8741d1c3a@redhat.com>

On Tue, Oct 29, 2024 at 01:42:12PM +0100, David Hildenbrand wrote:
> 
> >   static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
> >   				   void *arg, const unsigned long table_end)
> >   {
> > @@ -545,6 +569,15 @@ int __init acpi_numa_init(void)
> >   	 * Initialize a fake_pxm as the first available PXM to emulate.
> >   	 */
> > +	/* Align memblock size to CFMW regions if possible */
> > +	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CFMWS, acpi_align_cfmws, NULL);
> > +
> > +	/*
> > +	 * Nodes start populating with blocks after this, so probe the max
> > +	 * block size to prevent it from changing in the future.
> > +	 */
> > +	memory_block_probe_max_size();
> > +
> 
> This looks odd. Why shouldn't we allow someone else to suggest/advise an
> even smaller "max size" ? I'd drop that.
> 

Ah, my reading of the numa_add_memblk path was mistaken.  I thought the
hotplug blocks would start being created immediately after this in the
acpi_parse_cfmws path - but memblk != memory_block x_x.

Will drop along with other recommended updates and submit v4.

~Gregory

