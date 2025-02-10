Return-Path: <linux-acpi+bounces-10957-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC40A2E3B3
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Feb 2025 06:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 595A23A3C27
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Feb 2025 05:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1FB18C011;
	Mon, 10 Feb 2025 05:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="SeTSAN3B"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465FA158862
	for <linux-acpi@vger.kernel.org>; Mon, 10 Feb 2025 05:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739165783; cv=none; b=EIhans/bBuKdTadguFg4xXDvyG6LFV8YhH1iSiLhBLN3KOs1NXirdCDDeBJVcQb/B31yHwBxRNUQvLERrcCrU9MMSuK/H6Q5ZYrF5tcTXU1mAfcGweh0ij/W1Qra5OPmjJihKU+RJipKNiNU6IHllTSdEpum+ruUgE6pvDl3v+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739165783; c=relaxed/simple;
	bh=Asia1mOO54zhZrdtfcpdmZfzf3O5r2HXjzI1B6/5oyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qwZmCkVHEJ0Q9sDLQZMwYee2aESgG9lY3/P0GMdxUkacG5GlCGlabLS83kRD36bS19ZgYQqev8aICB5IcgP2r8amoTTx8CPYYlK7dFBEEQrwgzYVOVAke1ozaKU6oOkMXDmDuXzWnrM5i53c3v2RCcJDonDOiYsjr2ijc5lPLzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=SeTSAN3B; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6d92e457230so40165706d6.1
        for <linux-acpi@vger.kernel.org>; Sun, 09 Feb 2025 21:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1739165780; x=1739770580; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=09c9pCLCoJo3a2ZF5rhGJ5KRv33ZdK9lUhArxGuGrjU=;
        b=SeTSAN3Bw7leMg3+Z8TKjQqpR9xKVwaQtD9WzLHMPgrkY6tlURJBr67b7QSe7R4CTt
         TYWOr5iWgf73YIDlgUtI9HfqYIyd58t0qNPis6Bukaj3N95ZPBstCTgc5s5+DGzKx1Au
         BdXRlcYvgDuZpKlWc1jVg1pSdlHQN/qPg4kOhb+NyFYqGZH2G1kjrRRGejKOMykO9glP
         x28v1lED7eDc3qUIahHzLlMZPGDjTR9HCq7ujedddEBuH+OMnJgyULoOFkJDTOM64L0x
         iR/W13F0XaCpf2AuO/uiODSbJQJJPQwSM5QtREy4mI3Y98fg39XbU3491NbhZ8SOkmoc
         eVmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739165780; x=1739770580;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=09c9pCLCoJo3a2ZF5rhGJ5KRv33ZdK9lUhArxGuGrjU=;
        b=jMIkCPxan7X9rhJk0sP9NaeZ2ssXR4rXa0lbXd+AZ+b5bkU4sf+FMPdZf+B5Ulg4nV
         +FMEnJTtlTZheAXshqXQCbW1tiTnZU2C4mCzgaY/HBfwNoklh3ZfKRyQJuSOVulYH6IU
         vco9Odfqihhf6w6/Jgget9r8YORkNe7KVUjwoL/rXoJ/O08IHIyYLlc/D/9c1WYT+Mgp
         3IOBLqyyFYpghZ6wEwQ0Cy1RjMd/tX3Lklc5u0NBfEidN0pbsPb646e0WIu6C+FwIRet
         t+ayk258UNr98uknE4WY5KcnhquGjTcDhdHNEbKtfBJsZoGxNbuRZkqEKXiz6Op/ucoc
         i6yw==
X-Forwarded-Encrypted: i=1; AJvYcCWq+leZBt9SI8MOtwAllrMl9EfvYtWcZ4JtW0vvq0fo0O6kRNyKQEnaOPRMhP75CfaWlp2vHi2lVjx6@vger.kernel.org
X-Gm-Message-State: AOJu0YyvNljfH6NEU2NZ70g3S9KsEb7B1RqILstFizH58l0/wgna61Fx
	wa75kqfnon+ltRBy7tdNal+nqQWfNk0jgmH8ItIu+J6sdVrgd4KVbMdBoLEhRnU=
X-Gm-Gg: ASbGncsiyttdaEXrxk4WTnl1tqP+TmWijau9OJ7cBWOeYTB+zQRDsyc9of4DNaiM9yp
	OQrghjLtUVko8U0MTgyWdZCTAQVhhuJ9JJtlj3BKAjFdg0m0V892qewH1nEMO9JgSFUX3+udfN8
	lIgywWjoqBoPBF8vf8qHFaT9az5yd5wJt16avRNTkJ4c+rEUkBxmPITIBqGkXuI+sZBB1QJO0OT
	J8iOfpSzqHgY2ELBd406E7RvAMC8Cv6PZVzxjy7aVEemn/y81MwsV364vcUU7G7b4fOSqqh6hc2
	0aU7sAgXb7iQwpWg9ptF2vPlDObIgfsFi+2rLyGhPxt7rbxJ3n48gVBP92ERACl3CkLRe/Oo5A=
	=
X-Google-Smtp-Source: AGHT+IF6Xwj2y/UXrCF6adEWhGZUGebKXPr6MuXZBM2Fol5gpBA3Eof5/J6RhwSeBb8SVp0VBPxlvQ==
X-Received: by 2002:a05:6214:4108:b0:6e4:43db:205e with SMTP id 6a1803df08f44-6e4457407d0mr172866046d6.45.1739165779990;
        Sun, 09 Feb 2025 21:36:19 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e43baacb5dsm43149896d6.88.2025.02.09.21.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2025 21:36:19 -0800 (PST)
Date: Mon, 10 Feb 2025 00:36:16 -0500
From: Gregory Price <gourry@gourry.net>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>, hyeonggon.yoo@sk.com,
	ying.huang@linux.alibaba.com, honggyu.kim@sk.com, rafael@kernel.org,
	lenb@kernel.org, gregkh@linuxfoundation.org, rakie.kim@sk.com,
	dan.j.williams@intel.com, Jonathan.Cameron@huawei.com,
	dave.jiang@intel.com, horen.chuang@linux.dev, hannes@cmpxchg.org,
	linux-kernel@vger.org, linux-acpi@vger.kernel.org,
	linux-mm@kvack.org, kernel-team@meta.com
Subject: Re: [PATCH v5] mm/mempolicy: Weighted Interleave Auto-tuning
Message-ID: <Z6mQUIAOTvHj3wSp@gourry-fedora-PF4VCD3F>
References: <20250207201335.2105488-1-joshua.hahnjy@gmail.com>
 <20250207182009.7fc099c3074ad00338f25e0a@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207182009.7fc099c3074ad00338f25e0a@linux-foundation.org>

On Fri, Feb 07, 2025 at 06:20:09PM -0800, Andrew Morton wrote:
> On Fri,  7 Feb 2025 12:13:35 -0800 Joshua Hahn <joshua.hahnjy@gmail.com> wrote:
> 
> Leading to... how do we know that this patch makes the kernel better?

Just focusing on this question:

The default behavior of weighted interleave without this patch is
equivalent to normal interleave.  This provides a differentiation
out-of-the box, and that's just a better experience.

We may find the default values / calculations need tweaking in the
future, but this gives us a good starting point.  Anecdotally, I've
seen an "optimal" distribution of 10:1 based on the numbers run
sub-optimally compared to 7:1 or 13:1 (but better than default mempol).

So there will always be a "try it and see" component to this.

(Not to mention hardware/firmware lies regularly, and their reported
 performance numbers rarely if ever match their tested numbers - so
 *at best* this can be considered a best-effort feature)

~Gregory

