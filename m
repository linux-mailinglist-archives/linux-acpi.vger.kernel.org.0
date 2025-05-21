Return-Path: <linux-acpi+bounces-13836-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 328E3ABED3C
	for <lists+linux-acpi@lfdr.de>; Wed, 21 May 2025 09:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AD7A7A502E
	for <lists+linux-acpi@lfdr.de>; Wed, 21 May 2025 07:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD40623535B;
	Wed, 21 May 2025 07:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AXNewIAk"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E0D23099F
	for <linux-acpi@vger.kernel.org>; Wed, 21 May 2025 07:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747813396; cv=none; b=RN6e1ttdNLU7RDVRsPn3lpAHxu7mXOlHZdZmEXvTgUh7RnLL3lTi857kIoLmQYYGTNEcBt44seYGEndakeJj851c7l6OnOVdq4ZEw2dExy1sZzJYGtqXtVIspF4haW0Sqsm3Noo+QxJNrW1+4oqTqsHBJ5f5ImSo2wKQyJUhKm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747813396; c=relaxed/simple;
	bh=w1Dg5RsBUc18F5v8ye2RlpbIpog0I4kAhq9mtswyzPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WXfGDsNKXl9emcYvMHRhwbHfOWKEqdDrZ6meGaf4ctRhUZIGOlza6xsv4By+FHasmB9/a4ImFN7wQYSygE660Ccw0g5ntE+F4Hqsform2X2pQ9XhFb3yk854rkFuku/8pwBDVwWpehzUIOMY3hEzGa58o3Pi+T+RkqucizaV/Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AXNewIAk; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ad5a11c2942so185355666b.3
        for <linux-acpi@vger.kernel.org>; Wed, 21 May 2025 00:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747813393; x=1748418193; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J84xNzRgQa8mrQOkYbumbzzgj0ybXamBQeiJjclSyrA=;
        b=AXNewIAki3GoyYklTfjm8D/PVtqhlaeqDgmpiJIKCLTzDpNFzIf7fICuXGlzyY65wY
         G5zd0AhbrUnAJjZKVji6pUUExd5IB91sbqQYi63tCgvKPmVRBdNChJZFlu+IckBsfbcz
         05h5qBC2KkPP2BbDNEx4JYf8D4kJj8QCuNQ/b60NofU/qN4Rl3JTu0xnUto4f+JKPj96
         zeJd5X3qKU+N9t3X94adKzBNj2VT5VEaUNKtK94DNaiOUJf9YboTpypMKIeQ0qODcMcq
         nLziaqwz09RGW3gOSWmkLsULUxPGBofEK7suyuuW+ZVs+4H6juOWxx8wOXt9duR/Gs7y
         q7xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747813393; x=1748418193;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J84xNzRgQa8mrQOkYbumbzzgj0ybXamBQeiJjclSyrA=;
        b=fzfi/nHiHjrSDauho94W9gZV61eJAsxVxrL+fgIMmclh+Yy5l6vuGgZV+qbVt+reCb
         EU9DEJAMVWVTPMcQPXMJskSIQoad5tebDQXpwBz69CJQ7amKQw3wMqDN9FeC1mVApMBf
         R7NHZ46cTe4APFCQ4wxQ5CCK2Hegi/8c57eEXdZaeNEODD5LfIFVnvuzAvRoXaCOhrq3
         4wCFLgtUfTtZlTKKGVU81cJsHWcmksu9tXV9NMX0hSI3qKnlqXZElIP72kQrJQ8z8Ip+
         F4A7Mk6UfQKu++BYSFKYt27vBkEQWlQKvzbw8LiqGftaLkf6SIkr2UbcNK2LlsOqXLSO
         AYPw==
X-Forwarded-Encrypted: i=1; AJvYcCUOSlWC+u82l/D8+QBpaQGFch5Jc6iPM7tFzYsx4GLpcV9kW6NIJvo0NeRWNFM5k3MK9Hwiu5nusQFr@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu0M7g+NjWWYyZSaNjJIrqWEhE4KNiQ+yum8C2r9QxpGQAJK/Q
	kPl9av0yxy9NP2aGGjzSsXYYwZ14j940mQTsvk+8TsRnPoCdYn3RhUVe
X-Gm-Gg: ASbGncu2LgKnfaururD1cqPYPUiUgPtHpHWAAWVesMf3CVp3Pq+9i1TIGqoFEIe1quR
	1/6f7pED74M7pz8QXug58egBjI9f9dWhZGrngzXObv/jUwO8V8Ous/w8V6wOaELZetUkoeyw6cV
	Cu0rv8T5tDJzf+Wr8mT2xvR9WcmONxRhGNnVvrgFreawee8cmG0Zk+VIh2f8DoWHt3hSpifgYsu
	9AuWkLHi32vSKltvOvf32rwQ7a31f1YceFH7kdObejqRNRT3IU3omJNbIveOSTwSDiGzkXHPD77
	10MIHTk7U9/H4rRASjJaQ4ASDSwu8xKXuXXTQcQln2NX9CgP/v7QiH3lvGmFsPpa
X-Google-Smtp-Source: AGHT+IH5tn7Yh9xi/YcQ/171T3oryvhz9qm9/H/Z6ntY23ewvFkuclGodMzYYPJIYuU9jlPXxMJw+A==
X-Received: by 2002:a17:907:3d4e:b0:ad5:e0f:7850 with SMTP id a640c23a62f3a-ad536bde688mr1648749566b.23.1747813392931;
        Wed, 21 May 2025 00:43:12 -0700 (PDT)
Received: from f (cst-prg-94-60.cust.vodafone.cz. [46.135.94.60])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d06dc6csm868357266b.53.2025.05.21.00.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 00:43:11 -0700 (PDT)
Date: Wed, 21 May 2025 09:43:01 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Baris Can Goral <goralbaris@gmail.com>
Cc: oliver.sang@intel.com, acpica-devel@lists.linux.dev, lenb@kernel.org, 
	linux-acpi@vger.kernel.org, lkp@intel.com, oe-lkp@lists.linux.dev, 
	rafael.j.wysocki@intel.com, robert.moore@intel.com, skhan@linuxfoundation.org, 
	kees@kernel.org
Subject: Re: [PATCH acpi] Replace strncpy with strscpy
Message-ID: <rkc452hxtxcaym55croa5uvtjjsulbl25bhdk2mw2ce5fwqx4p@guhdxk6eogqj>
References: <202505191014.718ca1d6-lkp@intel.com>
 <20250520163540.6893-1-goralbaris@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250520163540.6893-1-goralbaris@gmail.com>

On Tue, May 20, 2025 at 07:35:40PM +0300, Baris Can Goral wrote:
> Hi,
> Rafael I dont understand your question. This patch replaces
> strncpy which is vulnerable with strscpy. As it stated in Link I shared.

Uses of strncpy are not inherently buggy, rather there is a corner case
where the string might happen to end up not terminated.

Rafael asked if that's what is being patched here.

> It seems it works to fix somethings.

If anything it seems to /break/ something.

In all reported cases the idle time went down significantly, which I
looks like an unexpected outcome.

So interestingly (to my reading anyway) this particular consumer
explicitly wants the target string to NOT be nul terminated.

The copied to struct is:

struct acpi_table_header {
[snip]
        char oem_id[ACPI_OEM_ID_SIZE];  /* ASCII OEM identification */
        char oem_table_id[ACPI_OEM_TABLE_ID_SIZE];      /* ASCII OEM table identification */
[/snip]
};

Later the thing is NOT treated as a string, instead it is handled with
memcmp:
 !memcmp(acpi_gbl_root_table_list.tables[i].pointer->
		oem_table_id, header.oem_table_id,
		ACPI_OEM_TABLE_ID_SIZE))) {

So, for "table ids" which occupy the entirety of ACPI_OEM_TABLE_ID_SIZE
(and which end up not null terminated), your patch changes the behavior
as they end up suddenly truncated by 1 to nul terminate, which then
makes them fail memcmp.

So the patch is not a nop and it breaks stuff afaics.

I thing the real bug here is that strscpy does anything of the sort.
Instead it should fail *and* be annotated with __must_check or whatever
the name it has on Linux so that consumers don't unknowingly introduce
truncated strings..

