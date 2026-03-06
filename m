Return-Path: <linux-acpi+bounces-21510-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFKlAo83q2mkbAEAu9opvQ
	(envelope-from <linux-acpi+bounces-21510-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Mar 2026 21:22:39 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FBF227763
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Mar 2026 21:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21D34304B59F
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Mar 2026 20:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A347142F542;
	Fri,  6 Mar 2026 20:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wZ+jzdoo"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A9B45BD78
	for <linux-acpi@vger.kernel.org>; Fri,  6 Mar 2026 20:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772828535; cv=none; b=Bb1iHv9tEhmUqmbq+PI66+P6XSA98ufHW1KBam6cbHdQluTLN6wPGOfAlSS3ar1xmwnMCWYKfb+7s8OHMHkzlQAUpZToSNCA8f8/NMEqDFA7w+gChiVQpxznN06SiSaZqew9J6iqDi93oHggnJr7FaEryOCiKFTKQNVLg7ywuiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772828535; c=relaxed/simple;
	bh=N/ru0EOFkc3AcpS21XeyDwquZX7JMKMkovV4eRQ1jis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E7VrOaG1EKIkD3/yxG7QhdxGTClZFxSmhr+pG5FpNZoRM2l9Yo3SiVmn+HlaBh1sX+ZcZtEvc4EsWhuSGDv241hlWtlbg5E+hZrIfZYet6xztAVgQ8CO5InNzIs5AyNHfM/yepEkuN+stssPFeJBCiyMXYqnnnBNCUjgMKhSo+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wZ+jzdoo; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ae4b40999bso565ad.1
        for <linux-acpi@vger.kernel.org>; Fri, 06 Mar 2026 12:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772828534; x=1773433334; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N/ru0EOFkc3AcpS21XeyDwquZX7JMKMkovV4eRQ1jis=;
        b=wZ+jzdooGqLXnitC+wxhTDC4MFrN98P50c/FrExACAGfbJnZpARrSo6duRLvHIjt23
         dgjEcoHZ+xnwF3P5RrEeO5An4iGzdqpXhNt2Mtz9MT2mq4hmgwE9IxZhr///iTTsxdIG
         AZrtIJKtS6BsKQsRrohiB6V930qh5ElQW/AfFpqhrleLWLOXFY74T57PlNCOSxesTHlI
         C4ZFh/rRsfaqRSxZMmARCISr8JI2dtG5qPv4SpQV8J6L7Y68UpWuE0/hlOhJ99cUuJO2
         oZ4DCPq2/lwXUfpyHB0fAIv38Tn9fWS1D/6X2+VtTEY30CNZ7VgRfciQoskm65svPSCZ
         tkTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772828534; x=1773433334;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N/ru0EOFkc3AcpS21XeyDwquZX7JMKMkovV4eRQ1jis=;
        b=TeSNFqZl3Z+W8F8dOzOyOSIr6NiP5cF/G600trwsjQv/7U0SzKOGOx/OTO3hu4vuGl
         XRmOxwyPCXDAh/I2+JprltHgqfPhkW4ycncuz8qZAB768Kp0ZUXj7Pi3q79q6Fzg9lpI
         kZ54yl9Q1STaAWLwqq5QgZ+D+K+1scVHiKFWbfaNWbvSTw4LMZ5hdMCQVl5OV/CZhauc
         jgbMIlQ7sbvLxj9jbKoe6qqCS5WI9fv39Wxv575RB1SJ6xwRnkpsfWk8NM+gOsOhdjgS
         JgyLRfz8MwHryIKD82K308wxBnrumAhoxOuBJgBA5VnAc/5dvWokLtM5SoXj0nykG0W+
         SmXA==
X-Forwarded-Encrypted: i=1; AJvYcCXvGKXTtbVUxDbyH97lJ5HCzGbcz6QjIa5QSn0boqA4MZ8/bFXkj0pz/iTEMLYc/i2ZQfdRNxp5HO/M@vger.kernel.org
X-Gm-Message-State: AOJu0YxSjfY20b60SQ5L2DIoDGAbYdNdU5B+SIFUPK/CpZezQoYjEO+c
	yjfR0AdW+9cuEF9C5SZHtJB/84VMBaTaIs+HIQoOlFGkMwn9ErqBvt5s1Jhdfabl5w==
X-Gm-Gg: ATEYQzxBzynY64aw4/rkikPFZNijfTwa+xLiDN3cCMXXrCvRuI0Fq3eLzJUFImq0C2z
	pjMK48NXXSkpv7TRQnybLvNNf+ubmUD4GxPc5hHizxlybqvhoh9NUCwBS56rkLAuwJKE9+D56sg
	v/XwofpZMKuyouiJTeokG+xRe08Dys1JwOMs0sVp8GjqKgoKI48FJZd/LgfjW8pwilXI7FSq8UP
	2ATEfX19Tbya6fJ5TKcMs53yYIUfLICOGS6+R3nqB9wxkk4R6P1a/A4tnMoH8oMR42xC0SkKm/C
	YvXX7FwyRfHi1Ezu9Ny9lO2ivvt5QhqtRDXYkDewvLrURETczG5+ZrH3h0JtTpFYpyGyBK380/9
	HmOEQG81WoeZ+8taeF8ecLV1e0IOgoTNS6NOhlGTgcMju1v0gOcfbQEGB404obZs57q0kqHJ1Zg
	mOwMs0iyDqo937FRXh0aQcUrpna1I1V6BCoPJ7SAWSFNgcd3GRoH2v+m64GmPd0g==
X-Received: by 2002:a17:902:e84b:b0:2aa:d604:62f3 with SMTP id d9443c01a7336-2ae8ad1ceb3mr443415ad.10.1772828533274;
        Fri, 06 Mar 2026 12:22:13 -0800 (PST)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83f7837bsm28280845ad.48.2026.03.06.12.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 12:22:12 -0800 (PST)
Date: Fri, 6 Mar 2026 20:22:08 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, 
	bhelgaas@google.com, rafael@kernel.org, lenb@kernel.org, praan@google.com, 
	kees@kernel.org, smostafa@google.com, Alexander.Grest@microsoft.com, 
	kevin.tian@intel.com, miko.lenczewski@arm.com, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-pci@vger.kernel.org, vsethi@nvidia.com
Subject: Re: [PATCH v1 2/2] iommu/arm-smmu-v3: Recover ATC invalidate timeouts
Message-ID: <aas0dLwKmZyL_iOL@google.com>
References: <cover.1772686998.git.nicolinc@nvidia.com>
 <ca7ab934bf0f433b62a5c15d42241632c4cb9366.1772686998.git.nicolinc@nvidia.com>
 <20260305153911.GT972761@nvidia.com>
 <6416b7fe-0190-4c7b-9a62-5da7d5eea794@linux.intel.com>
 <20260306130006.GF1651202@nvidia.com>
 <aasmWvA-sqi0KJwO@google.com>
 <20260306194312.GL1651202@nvidia.com>
 <aasv1HYOKuuJyi1k@google.com>
 <20260306200321.GN1651202@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260306200321.GN1651202@nvidia.com>
X-Rspamd-Queue-Id: 77FBF227763
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21510-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skhawaja@google.com,linux-acpi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.939];
	TAGGED_RCPT(0.00)[linux-acpi];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Fri, Mar 06, 2026 at 04:03:21PM -0400, Jason Gunthorpe wrote:
>On Fri, Mar 06, 2026 at 07:59:33PM +0000, Samiullah Khawaja wrote:
>> On Fri, Mar 06, 2026 at 03:43:12PM -0400, Jason Gunthorpe wrote:
>> > On Fri, Mar 06, 2026 at 07:35:19PM +0000, Samiullah Khawaja wrote:
>> > > On Fri, Mar 06, 2026 at 09:00:06AM -0400, Jason Gunthorpe wrote:
>> > > > On Fri, Mar 06, 2026 at 11:22:52AM +0800, Baolu Lu wrote:
>> > > > > I believe this issue is not unique to the arm-smmu-v3 driver. Device ATC
>> > > > > invalidation timeout is a generic challenge across all IOMMU
>> > > > > architectures that support PCI ATS. Would it be feasible to implement a
>> > > > > common 'fencing and recovery' mechanism in the IOMMU core so that all
>> > > > > IOMMU drivers could benefit?
>> > > >
>> > > > I think yes, for parts, but the driver itself has to do something deep
>> > > > inside it's invalidation to allow the flush to complete without
>> > > > exposing the system to memory corruption - meaning it has to block
>> > > > translated requests before completing the flush
>> > >
>> > > Yes and currently the underlying drivers have software timeouts
>> > > (AMD=100millisecond, arm-smmu-v3=1second) defined which could timeout
>> > > before the actual ATC invalidation timeout occurs. Do you think maybe
>> > > the timeout needs to be propagated to the caller (flush callback) so the
>> > > memory/IOVA is not allocated to something else?
>> >
>> > No, definitely not, that's basically impossible, so many callers just
>> > can't handle such an idea, and you can't ever fully recover from such
>> > a thing.
>> >
>>
>> Agreed.
>> > > Or blocking translated requests for such devices should be enough?
>> >
>> > Yes, we have to fence the hardware and then allow the existing SW
>> > stack to continue without any fear of UAF from the broken HW.
>>
>> And this applies to software timeout also I think, since both have same
>> end result.
>
>Any situation where the ATC flush doesn't get a positive response from
>the HW must fence the HW before continuing to avoid UAF bugs.
>
>Obviously today we just succeed the flush anyhow and hope for the
>best, and I think that is a good starting point for VT-d. We need at
>least that to build anything more complex on to.
>
>Fencing the device also has to come with a full RAS flow to eventually
>unfence it, so I wouldn't do it in isolation.

But do you think doing the timeout logic without fencing would be good
enough? Currently VT-d blocks itself, until it gets an Invalidation
Timeout from HW, and system ends up in a hardlockup since interrupts are
disabled.

Are you concerned that if fencing is done without an RAS flow, the
device might not be able to detect the failure (if it really needs ATS
to work)?

I am thinking, we can do translated fence and timeout change for VT-d.
And the device can use existing RAS mechanism to recover itself. This
way we atleast make sure that caller of flush can reuse the memory/IOVAs
without UAFs.
>
>I would like the unfence to be done with a fresh domain attach (or
>re-attach I guess) that just rewrites the context entry with the
>correct one.

Agreed.
>
>For VT-d that probably also means it will need all the domain attach
>fixing we've talked about as a precondition too.
>
>Jason

