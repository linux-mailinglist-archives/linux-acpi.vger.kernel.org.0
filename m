Return-Path: <linux-acpi+bounces-14669-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA11AE948E
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 05:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80B4A4A2975
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 03:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E5A19E968;
	Thu, 26 Jun 2025 03:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b="Zdn17Nmf"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A42E143C61;
	Thu, 26 Jun 2025 03:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750908796; cv=none; b=R/j6sH5JamUVZGg/TYp4E01IWt9aHV4VNxh39SaNifZ+eWqk5of5ILgyb7P1MzFXaqabivI8b/jrTABYsCeCRDujhcNIuqKwNhEqHwre6+Bvgm/Rxg2FNqzg8xL3oNwxN9vrkh1CNXZ9GKDa38xD4afQBwrW5C3O58OgRBhNvrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750908796; c=relaxed/simple;
	bh=Bc2g+Qu3c72u4kqoqbEKhlGpqe+fDkexOaK2Un4tJzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fde8CXzjdkJX8i/IztNNmi0y/Uzpw19rDGy4ZPuQuRObNwfmPM3mIrkFa1ZWElHH7KASQ7oivlxE5sYRFzkLy2Cybk0/FK0vx1k4Rc2YjN3YIydrA4BYnf55kHxZDEGndtQuWFGQEycLUzQxRvz0rhGlBuAGCiiBwPWLj0y+mwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz; spf=pass smtp.mailfrom=listout.xyz; dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b=Zdn17Nmf; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=listout.xyz
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4bSPQt4NNWz9tn2;
	Thu, 26 Jun 2025 05:33:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=listout.xyz; s=MBO0001;
	t=1750908790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7Umn1ROjvUXlv/wGvRDtBfHo7v/yJB8VRm6XCMCTobg=;
	b=Zdn17Nmf0RDg7J2Sudpz+52US2tzglAcsLPXE+tbezdAo84N0hOM5kOtNQntgiY7IU2Hsp
	mSH4vRJJHe++YGwSj6XCXx621G8muD+/DFjxr7wQo53MnafeieH1C4UqSO+CLiJtuNYWbu
	K8QXTY7afEkZ5B7YQfqPtpSKV2XO+hEzDBks2WNagCF4wcQBPkcldre6+hP8B3odD8KsXL
	gOFTaZ7VhmQueUKkO2bBuIbaTKEXVkBbL3lulP4/WSVBLmxs3YNIOBY+EYhZjV2xA3MlqW
	suZM0Pi6u1S16D0OEhKK0NnzFyq0vJnStZ4y/sxOADmneu9L+uu+sCkbC1ZJ2w==
Date: Thu, 26 Jun 2025 09:03:01 +0530
From: Brahmajit Das <listout@listout.xyz>
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-acpi@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, rafael@kernel.org, lenb@kernel.org, 
	lv.zheng@intel.com, kees@kernel.org, rui.zhang@intel.com, len.brown@intel.com
Subject: Re: [PATCH] ACPI / sysfs: Replace deprecated and unsafe functions
 with sysfs_emit
Message-ID: <z7agzq4gie7no2k4qevpt6j2xkefq3xzoi42sy52zger5jazjs@lbwp4qusghgi>
References: <20250624133739.25215-1-listout@listout.xyz>
 <202506261036.895ef959-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202506261036.895ef959-lkp@intel.com>

On 26.06.2025 10:51, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "WARNING:at_fs/sysfs/file.c:#sysfs_emit" on:
> 
> commit: 74191212ddb1a82ed54ddd75fcd820f3df79abef ("[PATCH] ACPI / sysfs: Replace deprecated and unsafe functions with sysfs_emit")
> url: https://github.com/intel-lab-lkp/linux/commits/Brahmajit-Das/ACPI-sysfs-Replace-deprecated-and-unsafe-functions-with-sysfs_emit/20250624-213919
> base: https://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git linux-next
> patch link: https://lore.kernel.org/all/20250624133739.25215-1-listout@listout.xyz/
> patch subject: [PATCH] ACPI / sysfs: Replace deprecated and unsafe functions with sysfs_emit
> 

Please do not use this patch.
-- 
Regards,
listout

