Return-Path: <linux-acpi+bounces-21507-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8MzdBRczq2n2agEAu9opvQ
	(envelope-from <linux-acpi+bounces-21507-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Mar 2026 21:03:35 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9482275D3
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Mar 2026 21:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CFAB6305872C
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Mar 2026 19:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3148843CEC2;
	Fri,  6 Mar 2026 19:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OrWt7DWb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF2143636C
	for <linux-acpi@vger.kernel.org>; Fri,  6 Mar 2026 19:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772827180; cv=none; b=rGcQ8DEnzggz9qcNSdpe4ZAvkinrmmH0Af4FJeIKLty4IxYN26fPXVrIwK/HvS6AGU18+oFwKnrjqjaHsrVnuGEHC2lb2UGmeJ4ekcfYnSOkl2yGE/qVsCJVeaATMdVgJerB+POW8H3c8Akg+f7HZz8on30GoEpcpkz1KzXQdnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772827180; c=relaxed/simple;
	bh=945rH/e5rNYp7DXMDC1/KmZIttMnGVuMabmAVl9nIC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OCYUra13bJsekYxkdGQHOVzWvXLUCz19VDNxHHBd6QPao+t/jb6bpcTZICYBDEO7VZNBCPDJR9brzdofsNRKNL997M1hls5Y7UAIuI+dBvuWu6FdByiFDRM3bETZ4Ospgb2sagKORt8gEOrpehXZYByWB26lq6awCZ8t0Aj1B8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OrWt7DWb; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ae49120e97so12525ad.0
        for <linux-acpi@vger.kernel.org>; Fri, 06 Mar 2026 11:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772827178; x=1773431978; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=945rH/e5rNYp7DXMDC1/KmZIttMnGVuMabmAVl9nIC0=;
        b=OrWt7DWbIRNvwgpJ1SXQfaUPeSPg/CMtLN4LLK77HtDC7TsRliYyagu2uKAMxouZEN
         D6ijFaq8M8csmb2299380mt4vwVXkFM1QNmVA8oIfKP+ogJClfFSKui1qKjMLELs674l
         HEPrEJ9web5tXJu+qIG1yFeI94nhABZBkCNCdAwLF8UZxvZu+050hH4+hEXjgNd/KpP/
         JKV2BwLymXLwasbv76dSsHU2wlNncZg6YBZkO/aWTeS80BYmD/m73wZPEzwYYQY+SMJE
         Df+3ndbkdNhXqHUImdG1zNXq2Na8Y+dYst5ALI3t6iAVKmvdEHHVKrmNkhPR9tB78HGd
         V2Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772827178; x=1773431978;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=945rH/e5rNYp7DXMDC1/KmZIttMnGVuMabmAVl9nIC0=;
        b=u8tz3itFz3PguRSL5PW9qLjJiWQi5ikpWUTrVO5GRfRq1N8WDK7NTnIOZo9FxDa+l0
         8VlT2aGVKUIDwzr/Ub9jiF2s8YbnGSNUho6APClFvIIRf1Si5IK0Misft+4PsSQe2S7+
         EZN8ve5iZyvCwl1uG5pYLQOu7BhalyzKlDMN8MS0W7NSqMru5+m7WzS4BrGVEVGROCy6
         RaPN4Mj8UWSHfssjSSfCfV4ZBKFW1e9lg+/AK8PXtXvt1wfI19VHPFoCWh4m9sI8Pqce
         Y1YJo1H61DXGprbpAUpLgADYBxUFapjXVRT+4pRg//pmDDE31J83GMo+3hSC2+ji5bp+
         DU5g==
X-Forwarded-Encrypted: i=1; AJvYcCXlIAQcYYJjJgP4tVCSeQfAHv431pjOdkGaWfqsZQ+pfmFzE+7yuUFS+h9cK2nm3U9nw6D6KI1NLc/Y@vger.kernel.org
X-Gm-Message-State: AOJu0Yw95yqrkYNevetzz+tfqrd6uSifAueKduz1G/cL2yYGqO3ydBpN
	KqGvImq/W6AwYbav3kxtrWGWvr0N2x8TK5tDwmtA1pg69C9ru12zMAvVbsbtbi6Aig==
X-Gm-Gg: ATEYQzywc2i1NdIkivY7QjpfHayvbG2FjDM1dE27D8pVCs0HyxIW2m0F6VNmfRSz2Kk
	UffZ/6N10wiEYLDcRKNG6B9D1X5VnbJ4Yymy5SwaqpB6bloIeNuWYiwzpi73uBRV1h0ZErMTu5x
	2d+vVwYz4nMYa/E+8H3pxlBtslmiaagZbPRHy6U9/IQrSyLear/FKSthYGDq84h+HFtbF2PaRZC
	mTB6+ruUt0Yfh2/or+11F6xwq3naEry+Ydx+VAI8cDcvIwTBr5k1NTR8ccF+AbnJYRpkGW9TiUA
	enlH2XCrG8Po7OI+CRr+/5HWriqJmBA0EWz4MY3M3fsoFdcWVDqpFm4hU4rquxf8co+mJbcdmZp
	AtCQGyN8dBcnAqjc7A9+fjuKwJrnMi8NaqBRZn6NxVlWT9d4NNKapuL/6IUhK+yhNzwvcJsB74d
	GMiw31DD3Ziw6slnhxwgwiJJRHFvtzL1KRoBPBOAAbvNhD0Jh93VFKEArORy4vWQ==
X-Received: by 2002:a17:903:2f8a:b0:2ae:575f:3755 with SMTP id d9443c01a7336-2ae8ad8939bmr404865ad.20.1772827178041;
        Fri, 06 Mar 2026 11:59:38 -0800 (PST)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae840b2130sm30703795ad.83.2026.03.06.11.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 11:59:37 -0800 (PST)
Date: Fri, 6 Mar 2026 19:59:33 +0000
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
Message-ID: <aasv1HYOKuuJyi1k@google.com>
References: <cover.1772686998.git.nicolinc@nvidia.com>
 <ca7ab934bf0f433b62a5c15d42241632c4cb9366.1772686998.git.nicolinc@nvidia.com>
 <20260305153911.GT972761@nvidia.com>
 <6416b7fe-0190-4c7b-9a62-5da7d5eea794@linux.intel.com>
 <20260306130006.GF1651202@nvidia.com>
 <aasmWvA-sqi0KJwO@google.com>
 <20260306194312.GL1651202@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260306194312.GL1651202@nvidia.com>
X-Rspamd-Queue-Id: 6B9482275D3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21507-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skhawaja@google.com,linux-acpi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.939];
	TAGGED_RCPT(0.00)[linux-acpi];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Fri, Mar 06, 2026 at 03:43:12PM -0400, Jason Gunthorpe wrote:
>On Fri, Mar 06, 2026 at 07:35:19PM +0000, Samiullah Khawaja wrote:
>> On Fri, Mar 06, 2026 at 09:00:06AM -0400, Jason Gunthorpe wrote:
>> > On Fri, Mar 06, 2026 at 11:22:52AM +0800, Baolu Lu wrote:
>> > > I believe this issue is not unique to the arm-smmu-v3 driver. Device ATC
>> > > invalidation timeout is a generic challenge across all IOMMU
>> > > architectures that support PCI ATS. Would it be feasible to implement a
>> > > common 'fencing and recovery' mechanism in the IOMMU core so that all
>> > > IOMMU drivers could benefit?
>> >
>> > I think yes, for parts, but the driver itself has to do something deep
>> > inside it's invalidation to allow the flush to complete without
>> > exposing the system to memory corruption - meaning it has to block
>> > translated requests before completing the flush
>>
>> Yes and currently the underlying drivers have software timeouts
>> (AMD=100millisecond, arm-smmu-v3=1second) defined which could timeout
>> before the actual ATC invalidation timeout occurs. Do you think maybe
>> the timeout needs to be propagated to the caller (flush callback) so the
>> memory/IOVA is not allocated to something else?
>
>No, definitely not, that's basically impossible, so many callers just
>can't handle such an idea, and you can't ever fully recover from such
>a thing.
>

Agreed.
>> Or blocking translated requests for such devices should be enough?
>
>Yes, we have to fence the hardware and then allow the existing SW
>stack to continue without any fear of UAF from the broken HW.

And this applies to software timeout also I think, since both have same
end result.

I am working on a series to solve this for VT-d and testing it
internally.
>
>Fencing the HW means using the IOMMU to block translated requests.
>
>Jason

