Return-Path: <linux-acpi+bounces-6362-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8534890632C
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Jun 2024 06:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9B902855A8
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Jun 2024 04:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C11A132804;
	Thu, 13 Jun 2024 04:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DlloofCB"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18322446CF;
	Thu, 13 Jun 2024 04:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718254484; cv=none; b=NfkgQrJhecKoCy3P417oEuVxZxTqRNPavmvTlpTJEuWNGtoD0hsughgoTfJdBWIVUhgoTn7y2MvnP3udsIP6zniyzlkDR7MRD8o5VvcSsY7ZXn5xiZ0XhdaMsPDEfdWdAObtSTzOuBMbhwib/mwVfuWqfpYdXw0XHCBbuzqGkCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718254484; c=relaxed/simple;
	bh=J+BhI/zGBK77styQbHQsQK52iwfQ8DKIrfeE1p8QhEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UtxD1DZwSNj0bDws9d1zJG75Tuy3QE/ryo0bkWb4zLNHYTNvtjOPLcm5mhYnhgG1rpcGaA5zAzg5gdqqx8RMVpu5MpgF1E1VHhaq/8e9Zx882SSQhep3pysnQvDR2wrRvEhbc/M94OOUior3JjMgs69vnpVjhg2W7kqVK68wRrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DlloofCB; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718254482; x=1749790482;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=J+BhI/zGBK77styQbHQsQK52iwfQ8DKIrfeE1p8QhEA=;
  b=DlloofCBT7GzZkeCkfCh9mjmnRB6hDX+TOIw7aUaSqMCmReQBmmybAFl
   363Es5YeFRkT+Yoe8h3tdoNFGmqdu01vlze1l++Vk/Sr0chA9CHFafqF3
   834EY9M4a24o4WWZX7la+Ct6jRpIAoAfPvDNBbvP6lcPZ9CBYR0Ych+Ti
   brj6jY55VA683WDhrkmej1okluqvIuBVCNNqnySYy22Bo1wR5lN1hNqNI
   sNCk3j5xyRHsYGHkxYAo5nfRMhuj6Hy09inf5Kc8mRrubPB4MsiD4AKZ3
   asfFu4aOk1CenchNdKPIKoY1nQzza0JbQXT0cIueoyOFUqxi4qy3BSLk1
   A==;
X-CSE-ConnectionGUID: mm3AO8wOSsuiqwLKPMqXuw==
X-CSE-MsgGUID: Q/rJnvHfTiKh2eBwLbqBFg==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="40457214"
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="40457214"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 21:54:41 -0700
X-CSE-ConnectionGUID: OA/DktYHQE2CLCRzrZj1LA==
X-CSE-MsgGUID: 6F+U8T/ESu2lCHcqALZ8wA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="77465931"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa001.jf.intel.com with ESMTP; 12 Jun 2024 21:54:40 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 8848612C; Thu, 13 Jun 2024 07:54:38 +0300 (EEST)
Date: Thu, 13 Jun 2024 07:54:38 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] gpiolib: put gpio_suffixes in a single compilation unit
Message-ID: <20240613045438.GP1421138@black.fi.intel.com>
References: <20240612184821.58053-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240612184821.58053-1-brgl@bgdev.pl>

On Wed, Jun 12, 2024 at 08:48:21PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> The gpio_suffixes array is defined in the gpiolib.h header. This means
> the array is stored in .rodata of every compilation unit that includes
> it. Put the definition for the array in gpiolib.c and export just the
> symbol in the header. We need the size of the array so expose it too.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

