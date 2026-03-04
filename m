Return-Path: <linux-acpi+bounces-21358-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Le5FqKzqGliwgAAu9opvQ
	(envelope-from <linux-acpi+bounces-21358-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 04 Mar 2026 23:35:14 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA02D208B0A
	for <lists+linux-acpi@lfdr.de>; Wed, 04 Mar 2026 23:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 304A9302E907
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Mar 2026 22:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87BE396562;
	Wed,  4 Mar 2026 22:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Jb1PorJb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F69371CE1
	for <linux-acpi@vger.kernel.org>; Wed,  4 Mar 2026 22:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772663611; cv=none; b=mU9/SQ9T8b042SacZ+qarJPpZYlRsohxN21oGi0cgRwnU7T6+634IPkpn6e7uE4P3TXGJg9dqKI2lRsMwfKsejvJOeOZaN7PkvzAKJ1vLkDoF300LCfyBumtCne3yfcw+rzwm9jow/P/CXquY+twOlZydkoy4c96YXKl/uJxkcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772663611; c=relaxed/simple;
	bh=prulmfQJPM5sB8UVZonMzpxbfN/QSE7fFKzD055GD44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ueg0zQKRfyQpe8eZxDDjTFr9M4XPjz+7jQKuSbIlmpX8ICMi6kICtT+euWESe6DE/yXtgHnGNB+nNPg3gV3RDF5SQp28kASYOYfykqz3HwI2kqlKKCP9/dY8DKxeD2NJkO5JFki3l2mXCJkElW1M8LghUWZ5MTA+sCvSatQcnSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Jb1PorJb; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-89a07f66f4eso34750386d6.1
        for <linux-acpi@vger.kernel.org>; Wed, 04 Mar 2026 14:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1772663609; x=1773268409; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yqt1lwHlXdfsdp5rB//PPPVMKmDVYi0PoyC8O+e52Kk=;
        b=Jb1PorJbTBNCm8VlzIUw4A4KTVk17CZUCIKxuLnbGm+tlNTFFJth76/A/PrKAgYrQ7
         YKhyiAgpt2PYEgmIk8L+XbdlgKVQ10AvZ2UzmlIF6IGbnJOZs2m7khHu6HebB+Smqm5/
         nmPeJPXKNkVvDmym976BthXIOkW1iKmXczh4uLlOAQPKEAczrzdtcN9tv1IwCCA9IVGk
         WBr4wfu50+ZcY2nUkGAyQwNjf1vauNV4SdPUJrt5aq5w0cFtTDnPpHvGS5ef4XsNmu+A
         oSagnZXTqG6U2X23xrwGoDQ9X7X5ygtPGm2wDaPzmVYME3Yrwv1rLSAH4Vznl6xTRugJ
         3Prw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772663609; x=1773268409;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yqt1lwHlXdfsdp5rB//PPPVMKmDVYi0PoyC8O+e52Kk=;
        b=chjPF6dgDFTjCigGpWdM44iWd1oxfyeWq6+c0Rrpd+SfK2DWwA0FDfvyBdZY19Jgaq
         bV9EgAhC9MaS3SVpbyMm/nkkohWzXNJOIul2nNaP8PTZAsDstQ6SmlWHL+3vgnZgSptT
         qeI2DwOBlnkxX2s3U4OSTH005kq7B9Cw73pSqr3Nh0Re1i1o2gbJ72/xChXMobDOxrXi
         BZSjAqNq1c/7D6Aj0a9WOAzbHhu/ORDhiRKDrfN2XONde3TIWMDUKpiA0g8E4Rb/5VCE
         q+gDp1tjpIaIkQZqINT2XHrFeA+t9l/EL7pV5DVSgZzmce0imdPoGHTusi5OGE4yg3VN
         Ipww==
X-Forwarded-Encrypted: i=1; AJvYcCWw1jtR5gym311LJ4fTHfK2TrWwAEtPTCu+CMlELzPcCCEsKjERiB5Smzt4s0/kQgypW4YexLLeb3Mt@vger.kernel.org
X-Gm-Message-State: AOJu0YxifGrH5muJw/Tj/KA8dyXKKDZUp7B8sfnlmkgkX3jeK33sTOGV
	ILMvEUrOJzuanNogcIxch/S+dek5udjwwpYqBIP/+i4rx39JtQ/T5SA/o6c5Wz0enCU=
X-Gm-Gg: ATEYQzwNcndXDkuxEybNp/WXF+l71YZKekk8hzMflyU8MhEPRxWqMDylpJuudhWAJ/+
	htj5HJ79fUcvCJDJJCfZ38P/zuY0nxodW1tItEGGXnFddZ0il+R9UTxJyrikf1m30AaIgL5IqjK
	AvPxEzZRO9d/Ah63fp9Fl8n8sP6YnW2Q83cfu4CINCjKtJTPEyR5z23NFC2nyxWrd3LF+E7hTjI
	4GfmPRMCeSZfTio7B3CK8Z506/erDzVK0jXTCtWg/+BERxoJecTgzhs+hi4gWmfc7+bjJYuRr8e
	PiYSntMVPu5MlUdLX2kM2tWNbI7futvARXS+aWGfDW22wwvAAT9s8WjRrXYvCBnE+72nNzNA2my
	UT1vLlX+6znx+EJASQoOMsiS+hMCb6CRSGDo7ByoZhH9Ii8MOhr2I4DDfKx5QKamlBYo8I7nQW+
	6FfYrHqu9rqv1uYXfCcvyd33NSNEHKvsIKjM8Wl5uvIXO3KFFvvUG5BfA9aBbKUNsqaNiIL+Bbu
	3FSi7HbwFVNM8HDIOhb
X-Received: by 2002:ad4:5946:0:b0:89a:9b1:a225 with SMTP id 6a1803df08f44-89a199852b9mr56252546d6.12.1772663609341;
        Wed, 04 Mar 2026 14:33:29 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5074481c0e5sm183664431cf.0.2026.03.04.14.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 14:33:28 -0800 (PST)
Date: Wed, 4 Mar 2026 17:33:26 -0500
From: Gregory Price <gourry@gourry.net>
To: Kai Huang <kai.huang@intel.com>
Cc: rafael@kernel.org, lenb@kernel.org, dan.j.williams@intel.com,
	alison.schofield@intel.com, akpm@linux-foundation.org,
	nunodasneves@linux.microsoft.com, xueshuai@linux.alibaba.com,
	thorsten.blum@linux.dev, wangyuquan1236@phytium.com.cn,
	linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI: NUMA: Only parse CFMWS at boot when CXL_ACPI is on
Message-ID: <aaizNh-0LEvRQMCy@gourry-fedora-PF4VCD3F>
References: <20260304213342.5776-1-kai.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304213342.5776-1-kai.huang@intel.com>
X-Rspamd-Queue-Id: AA02D208B0A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gourry.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[gourry.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21358-lists,linux-acpi=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gourry.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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

On Thu, Mar 05, 2026 at 10:33:42AM +1300, Kai Huang wrote:
> Increasing the 'nr_node_ids' has side effects.  For instance, it is
> widely used by the kernel for "highest possible NUMA node" based memory
> allocations.  It also impacts userspace ABIs, e.g., some NUMA memory
> related system calls such as 'get_mempolicy' which requires 'maxnode'
> not being smaller than the 'nr_node_ids'.
> 

Is this a Linux issue or a Firmware issue?

Is GNR exporting more CFMWS than it should?

Is your SRAT missing entries for CFMWS that are otherwise present?

Are the CFMWS empty? (is that even valid)

> E.g., on the aforementioned GNR platform, the "Slab" in /proc/meminfo is
> reduced with this change (when CXL_ACPI is off):
> 
> 	w/ this change		w/o
> 
> Slab	900488 kB		923660 kB
> 

This is a good effect, but I still question the premise.

We don't usually want #ifdef's inside of .c files if we can avoid it.

~Gregory

