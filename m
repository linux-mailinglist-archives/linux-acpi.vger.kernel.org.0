Return-Path: <linux-acpi+bounces-21503-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iEQdIIEsq2n6aQEAu9opvQ
	(envelope-from <linux-acpi+bounces-21503-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Mar 2026 20:35:29 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 220A6227167
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Mar 2026 20:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 391EF301BDF2
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Mar 2026 19:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C79E37268A;
	Fri,  6 Mar 2026 19:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CFK07eG0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDAB361645
	for <linux-acpi@vger.kernel.org>; Fri,  6 Mar 2026 19:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772825727; cv=none; b=HHpwmXXSnoFZdSF1fR3pbSftUgio+ZCTWgF9hOBHIF/PuwMCMZpzYwM7DwP4wg/TmfCn/+aLVeU1vgQbmO1A9AJV1HPecpC03qoYu3riHZ6aULn7INp41cNo4k3AZhO00ludMkd7mo+Ba/8GyHMFKtM15PgpyPOUzldaiEoQUsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772825727; c=relaxed/simple;
	bh=Wh5Z913UZEh7i6f061EXZd6SLJhL4kwsCncFeqW4SCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F65mIauppZZDGWM0WU43WDknPKWbD8PEeUs27Kdf8Rcxmn3J0ktnR7MhQ6HiIE6AbnGwmXy0/jd29C5Xaq9LQDHrdcgN+Cu6seyKhVKVbCc6NNsYBGIjR8wf/De7Bc/9loz0pBdwYmjZr6eJ8471XO/wg/7/n0IaHoc6Zh5y7Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CFK07eG0; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ae4b40999bso9935ad.1
        for <linux-acpi@vger.kernel.org>; Fri, 06 Mar 2026 11:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772825725; x=1773430525; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wh5Z913UZEh7i6f061EXZd6SLJhL4kwsCncFeqW4SCA=;
        b=CFK07eG0WF2ukRdWMfJ1bk+tVIMO6aCAGhmXdH2I+69FHElggzTK+pbdoc2ywyYDmO
         mRxNy8Ys+y38L+hw5MKQvwfISeiXrHj4LThbbkKNvuP7YQcPhA/lqlL7V363JnSTE3yj
         mgbw0k9HEYC+3wnZ0z71WGNGjp/ic89HWYkqYRStsbIr6g5KrsmWPnhVIVm3uweK/v0H
         IwbqZ307Fj0qZvF10foTeeMt1xs6dQO6AyYVEtoYiQ1jABSn13edG9auy5wK6lfDRulh
         lGwAZ5wofgJD/mYjFiK8YkfqbrGj3nh79Jzd5MMuKqRg06mtaKgw8FkHudYVKycpHF5C
         Ibhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772825725; x=1773430525;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wh5Z913UZEh7i6f061EXZd6SLJhL4kwsCncFeqW4SCA=;
        b=ucAI987fNng7dK8GsvrhbfWdK1u9kT8titoW5jTac8ErXu4URugeTM5IlQKOgWLyUc
         Oo+sQDBcX3/loLQidFrSEm7HWssJQdvQiMsOASJqSXFcP/7Imqrec1CPXzfCNItKtimb
         jzXdmdtAFs9l3ntUs66XbvdmydnK6Q2c1DSKeiqb7mgg487pI4DQAbB5t6UzL05ql+m5
         CydSy302JSGu0hGFO7sY28NL8M6F83HzYDCyx5dOiYvhk2+IKAqou5A7cXEnvZTNMTU1
         IG/RDxcgNu+iY1axQS/8n5HWyf2hqP/nug1bL3XUA1c50vbs9Z8iGqJ/nqdsweQXeCfS
         3xnw==
X-Forwarded-Encrypted: i=1; AJvYcCUqE/0ySkZpyFpkOR3T+F8/QDfHPcdq1VihAdDujVnEYr70F8LKJF1UeLb7LmYSbhhCmMf1DynTpgM8@vger.kernel.org
X-Gm-Message-State: AOJu0YzrP0GQHB8Qz8h8xXHwj0ww3zaLZAmgCszNTdDsGHVe8mpJ2Ktg
	ReKuyKHA9++tJ0OlOfWL+7Per3tOjJERtv0mfCwznAm2+HOr6DvxUYVkBLjZpaiG1g==
X-Gm-Gg: ATEYQzxO4dsSpFdPROwnYe2Rb/l62wSH/N2i+zezDw7O9nb6SGJx7lJzChk8aH1sNOm
	q8rX3gi0UrUwXn1bpHP2uwQKkBkEpQhLksuhRcBKeT6T4x72T0w/jPRf5uczM/9Ir40TQWNQ4iT
	wDti79ufdN2pq/3FQAHiHe9NmrmdzASif5C8eqWzd7MIdzcz7vTIENy3FKZFZKXM5EXKqgPw8MZ
	SwHOYWCZWJGWPFgYcmyzCGeCRjlhzEvwGwG6pVVb5NiJkgRSgI7TRON7t1UVrecmWjmPD+osKSX
	aNJbGyasAX4sxD8xWKoFE/KOj1fvgpDTw9dHbfPI2eOUm/tMbWi1axAR8CsriluWoU63kDxyfGX
	Fm7BiT6uf5vt95YQE01KaCzBzQE6PtIrZnH/VsSFdj+IYiWGHC5aLBbqRk82FOPHaLUNwNweqmB
	hgw43iIsRZwJO7cPMAURsthWXZPiKU7DLAcHheBGTzle0t6g+lCIzYSUrdzR3nCA==
X-Received: by 2002:a17:902:f545:b0:2a7:d266:d84a with SMTP id d9443c01a7336-2ae8ae4e111mr191585ad.17.1772825724928;
        Fri, 06 Mar 2026 11:35:24 -0800 (PST)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83fb3cc3sm27116245ad.73.2026.03.06.11.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 11:35:24 -0800 (PST)
Date: Fri, 6 Mar 2026 19:35:19 +0000
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
Message-ID: <aasmWvA-sqi0KJwO@google.com>
References: <cover.1772686998.git.nicolinc@nvidia.com>
 <ca7ab934bf0f433b62a5c15d42241632c4cb9366.1772686998.git.nicolinc@nvidia.com>
 <20260305153911.GT972761@nvidia.com>
 <6416b7fe-0190-4c7b-9a62-5da7d5eea794@linux.intel.com>
 <20260306130006.GF1651202@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260306130006.GF1651202@nvidia.com>
X-Rspamd-Queue-Id: 220A6227167
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21503-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skhawaja@google.com,linux-acpi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.934];
	TAGGED_RCPT(0.00)[linux-acpi];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Fri, Mar 06, 2026 at 09:00:06AM -0400, Jason Gunthorpe wrote:
>On Fri, Mar 06, 2026 at 11:22:52AM +0800, Baolu Lu wrote:
>> I believe this issue is not unique to the arm-smmu-v3 driver. Device ATC
>> invalidation timeout is a generic challenge across all IOMMU
>> architectures that support PCI ATS. Would it be feasible to implement a
>> common 'fencing and recovery' mechanism in the IOMMU core so that all
>> IOMMU drivers could benefit?
>
>I think yes, for parts, but the driver itself has to do something deep
>inside it's invalidation to allow the flush to complete without
>exposing the system to memory corruption - meaning it has to block
>translated requests before completing the flush

Yes and currently the underlying drivers have software timeouts
(AMD=100millisecond, arm-smmu-v3=1second) defined which could timeout
before the actual ATC invalidation timeout occurs. Do you think maybe
the timeout needs to be propagated to the caller (flush callback) so the
memory/IOVA is not allocated to something else? Or blocking translated
requests for such devices should be enough?
>
>I don't see how that can be made too generalized since we are running
>this flush stuff in irq and reclaim contexts, it has to be very small
>and targtted without memory allocation or sleeping locks.
>

>Jason
>

