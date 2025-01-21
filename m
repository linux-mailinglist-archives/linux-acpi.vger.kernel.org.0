Return-Path: <linux-acpi+bounces-10779-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC81AA185EB
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Jan 2025 21:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1F55188B82C
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Jan 2025 20:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BFA41F470D;
	Tue, 21 Jan 2025 20:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="GHAsLbcR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53F5129A78
	for <linux-acpi@vger.kernel.org>; Tue, 21 Jan 2025 20:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737489772; cv=none; b=i6iW6CHRhBN3sG0w+OFGhKoJEQWPsrucIheZIMw72UsyGq5q/40pC7xSzrJmvWu26zpLDHWxDTG7WMU41QIirx6erD/roqUvKCSr51DZxUH7/o99uxMeMeZNC+PD31WXqcUGGtJXF3v6tqey5g/MeoxSIP7QrXYhoRTfA3wSyq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737489772; c=relaxed/simple;
	bh=H/Q3YUsmUpkM546v/vTp4ocpzYmmNWq60MpD+F6eEFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J+O2YuZt+MaV+lEtU67qKWiXW3GZJxheJgkOHW4YFfjavRFlWx8M4TcJiFLirF+mnaP/yKn5mgqZohdU4+QusdSXcqgrA3EqcuGNLnEc0TOu6/meD0DBkgNPtVEV/29cUD/aUwhKCtC+acjCkW4k1NNRZVn+jW23+k39jNmM6C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=GHAsLbcR; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7b6edb82f85so803402985a.3
        for <linux-acpi@vger.kernel.org>; Tue, 21 Jan 2025 12:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1737489769; x=1738094569; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y3OIVWfkgtUAiX31YkBMTeL/DLtPiayo47VWYrPFfqg=;
        b=GHAsLbcR/Yh/DQd1Uy18BuppRyO5tD+WJQRnnI+etUkYGCEyTGDayaV9lBTHySCaEf
         lR1Gj3Jhdudbos4KJIzdh4LJ/uGFzj0/6e2Y0irzlxu8DgmNvrfa3igL2lg9JgOX2kY2
         ++jOwqkec28amJXToqcay1A5tj394f0cEGGEMluxgZO8D+OlryMgbWIfSlPqnpbgosxo
         fdS5eoFcCGNqX6waQKMYeO/C7Xu2fOCrNxVnevRpwrYot6So45iVsockdaLsYf9mQ7Ah
         ALER85HZSwG6xZeU4dkqAB/hWJGRDwNwey0+kIuNfmsm/sRXXmuOvg09CO0bP+xeWamn
         3dDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737489769; x=1738094569;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y3OIVWfkgtUAiX31YkBMTeL/DLtPiayo47VWYrPFfqg=;
        b=u3jwN8eFp9R3YUnZlNAPERkj04r3Q7i9RDlRE2B+BwvkdHZOwXSnrj9g2M2nG0gxEk
         qQuyGbsKzl+OON26R7YPF53fxJLUYQLUAY7zZbMuasyj9TaN2gIEeZKNzmx4WChMjGEA
         Rr8S01DETxLylaa1TgKCB/ErhX51jcaaLShHoMpS5Nciq/RFTmGomZrNoAGjM5tvuMwk
         sQe68tnFkHO2r7+wXBq3tpCD33Qb+5F92qBO5JZ7R31H6NWHXvLQyVRhDRKxYvu/ufaJ
         yHJPlxLBmHTJRm9Drk9QzuG3gdLpOsD+FiaRfQPiY3IGdW0+M3sOJxcHh6mdqLfwYQUQ
         WDYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgKVhjCpnfFN6hBQ6y+OxBy8oW/xlgZl6ox29vv1ypIbPK9t+/C5fgi4Z7G+ueLp1xm9bEgb8vThnD@vger.kernel.org
X-Gm-Message-State: AOJu0YykDQ3Z4mFLTGCWuJZDapU5fEXRAjFifnzj7mSRZWEXzXJeh7n2
	Y0r22J6Um2x7ZaOznmiXqMMfjw827eaVCZC6BcSg/gfZaCF/9haE+LF/OaGpYMQ=
X-Gm-Gg: ASbGncumBQkWJzORhJzdTF3cbytkcP47PNzQUg9rFK3xev5kgcU9TLr0zonvlf8G7om
	26HkUbTSVjU+Mfmn1jPEyD/oA2AJjIojfzpYUrvnqespWr49ANHhJhMVAmKhcNrjkFvjOEUbNuW
	zDLOmAKI02iswKU9Ita5RUbYvR5nYLeejpkh+RWLovcHko0SYT6Hw1G8xH+ope5zWRsEhcVPhhT
	pkZJ7SgV81CxazzD9Kl05DxtzjY6u1qedMr8p4hkB5hwAFg7p1KxOi8jCGlbScfA9HivrIJsuK6
	rH/+67bA1FXSGf/hoZJK1hyTs+bL+7U+BaeHxKnmOkC3wCDzQntl
X-Google-Smtp-Source: AGHT+IHXwpvIHPv5sKnU+umZ7vn4igy4P4XDOftH8A6JMGTfJEfhQhF1hHFvJs4VCsRttlDk7ECwqA==
X-Received: by 2002:a05:620a:2894:b0:7b6:e47a:8e14 with SMTP id af79cd13be357-7be6324fb5cmr2839107185a.35.1737489769284;
        Tue, 21 Jan 2025 12:02:49 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7be61480996sm585370585a.41.2025.01.21.12.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 12:02:48 -0800 (PST)
Date: Tue, 21 Jan 2025 15:02:47 -0500
From: Gregory Price <gourry@gourry.net>
To: Honggyu Kim <honggyu.kim@sk.com>
Cc: "Huang, Ying" <ying.huang@linux.alibaba.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, kernel_team@skhynix.com,
	hyeonggon.yoo@sk.com, rafael@kernel.org, lenb@kernel.org,
	gregkh@linuxfoundation.org, akpm@linux-foundation.org,
	rakie.kim@sk.com, dan.j.williams@intel.com,
	Jonathan.Cameron@huawei.com, dave.jiang@intel.com,
	horen.chuang@linux.dev, hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-mm@kvack.org, kernel-team@meta.com
Subject: Re: [PATCH v3] Weighted interleave auto-tuning
Message-ID: <Z4_9Z_TfVY3VOMHg@gourry-fedora-PF4VCD3F>
References: <20250115185854.1991771-1-joshua.hahnjy@gmail.com>
 <87ikq8h0w4.fsf@DESKTOP-5N7EMDA>
 <147aba6e-7e23-4ad1-9bd2-1ceac0f3d55b@sk.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <147aba6e-7e23-4ad1-9bd2-1ceac0f3d55b@sk.com>

On Tue, Jan 21, 2025 at 08:27:17PM +0900, Honggyu Kim wrote:
> Hi Ying and Joshua,
> > IMHO, this interface is somewhat hard to be used.  Users need to know
> > which value is legal.  So, this will become something like,
> > 
> > $ cat mode
> > auto [manual]
> > $ echo auto > mode
> > $ cat mode
> > [auto] manual
> 
> This is exactly I internally proposed to Hyeonggon, but couldn't share
> the idea directly here.
> 
> That also makes sense, but I feel like somewhat vague what "auto" false
> means. The "auto" might be better to be "use_hmat" instead and this
> makes "use_hmat" false more meaningful. "use_hmat_weight" or
> "use_hmat_info" might be another candidates.
> 

I don't think we want to encode hmat-ism into the uapi. In fact,
mempolicy doesn't even know about hmat.  It just gets source information
from *somewhere* and applies it accordingly.

I think what you might be asking for is

auto -> [true, false]

if auto=true
  mode -> [default,
           read_bw, write_bw, combined_bw,
           read_ltc, write_ltc, combined_ltc]
if auto=false
  mode -> [disabled]

Where default mode is the kernel selection of whatever combination of
read/write bw/ltc data, and user could switch the attribute.

HOWEVER, such `mode` would require us to cache the attribute structure
per-node, and maybe some thought on what's reasonable, so that I would
prefer that to be a completely different feature / discussion.

~Gregory

