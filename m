Return-Path: <linux-acpi+bounces-6019-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDFE68D13E9
	for <lists+linux-acpi@lfdr.de>; Tue, 28 May 2024 07:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 196F21C21944
	for <lists+linux-acpi@lfdr.de>; Tue, 28 May 2024 05:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D041C68D;
	Tue, 28 May 2024 05:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="coYRafhQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2018A17E8FF
	for <linux-acpi@vger.kernel.org>; Tue, 28 May 2024 05:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716874287; cv=none; b=nCkYf2QF9uqHZGUh+bhmuW8xL5h+OQg1ib7K6wL1RviuTLQQlhPA8fDwOXO9jM8itbBpjMIRbAqo811jF5YDsB6nfjEygZohsIgz9zWTeZqgSkRpD+ssRZk134GcQ0+ez2ByMc9gdGlsHwBajYoGcgDr70VMYEgb7R+/+btYJi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716874287; c=relaxed/simple;
	bh=HyQLjZEpd9wwdN20s4cZ6BruH/hZKkcc3iKQN6LiTVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KkzSeJsVZ6fQrFtqcpmjhvOqnDZ1UZ3Y1jML2rU29fpz1y7uz/XpueLyE0m7nheD+zHEFpW+erXj4hOohob4z34mRbnLS83MRJiw1znHgj8kEx38RVvqVfuosOJykAhkrszGfQDpDm7WBQgZORlg59+X6EKyY0P6Ewe3LEtyuyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=coYRafhQ; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2bf629ff55bso314537a91.1
        for <linux-acpi@vger.kernel.org>; Mon, 27 May 2024 22:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716874285; x=1717479085; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9hvPgmffj4Wj06vdVO18Z5LSO2FFEsKmLvRZE6+/qIo=;
        b=coYRafhQcdlkUxMpwjQWk91T7cwG/0FsJ9QyoNq08+8VJ53ZMQ/bt4WwhvQU12lGTk
         6gU5VxqkVkoJhTu+7qMOooJM+5doGC3cfSSoZCPg1EFN5vD5Y47lAPI69EG16S74RBPH
         VR8Ct5PEkc//IDX2Pr+teporNm51VYGs13V/o5KIXAgSwTDMntYq9FmofknRefIXPEof
         55QyCn+kqbidwGkBTBsdt5ZMrI0SfiYjn2kqIvvj//FIaGXuWcAuFtwgyG5NiN97U5Cl
         C/WK/Et9W93AeauutbRlLNVxK4QjhysdCmYWgu1aaG4vN/cUtPAImbA65FwMtlRbdQv2
         SU9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716874285; x=1717479085;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9hvPgmffj4Wj06vdVO18Z5LSO2FFEsKmLvRZE6+/qIo=;
        b=oKItfMQxDgvCLBOZVJtl1kaRia8m8+u0BcPj63gaOnPEsUsoAWRYKqepour/kKVFnO
         b9RbRlvrp4UWcU/4h7vxvWADtO8/1U7SPmRvRVKmunh5+APWuOT5jd+V2/Vkzt0gNlM5
         +i1g+Jj+Pnb2END1z+pgXMOTtku3IzA0nxLZ5rKjU7uWFToSa2cx9XwJTDd68fcdqzmK
         yegS8K4c/7blMLO/rAuvlSSojHxG+lVbDyrLWw/28kJab1FhJb79wW83wo11KG9tOSDV
         VNN1pz/w9Mz9eODtAuA3dy3xcphVxU8Yxrvd+tadu7p9egriZDRvtrExnaGYthZ9Dq3T
         wIpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwFV3pnfwy6YNv9ABJqbH3in7Od3E6XtHi+YiF3aRK5ExJ1tgDPgbXl3g2V7oGIh+b8W5w4lHN6SrY3nwFxDQ8VOqvmw1UOfF7gw==
X-Gm-Message-State: AOJu0YzbkypVPc10+KHCKR9uWSwTCqN3Qnf73LCyvMQx6hK3L/l6FfOv
	zw6/umlzOC4kAuCGbgSq1w5v6w3N7JB32qLDyMYWGpXuFzoDaeRHG2FD74nCL5s=
X-Google-Smtp-Source: AGHT+IH3eeCklWFIBgjuU2ajwASNK+Fln476Y1+Xt+QjngmUQhquOGzUKnaJQt7MCEQySQmbSAajXg==
X-Received: by 2002:a17:90b:3754:b0:2b4:fcfd:780e with SMTP id 98e67ed59e1d1-2bf5f75124fmr9077103a91.49.1716874285301;
        Mon, 27 May 2024 22:31:25 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2bf5f511a92sm6769359a91.24.2024.05.27.22.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 22:31:24 -0700 (PDT)
Date: Tue, 28 May 2024 11:01:22 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: oe-kbuild@lists.linux.dev, lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-acpi@vger.kernel.org, devel@acpica.org,
	linux-pm@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [rafael-pm:bleeding-edge 11/15] drivers/opp/core.c:2447
 _opp_attach_genpd() warn: missing unwind goto?
Message-ID: <20240528053122.pzfkdig6k4kga2yz@vireshk-i7>
References: <3d73f08e-8305-4ad8-8327-adaaf96ac673@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d73f08e-8305-4ad8-8327-adaaf96ac673@moroto.mountain>

On 23-05-24, 15:50, Dan Carpenter wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
> head:   fe07fa9fa1115e0979b89a90ae8594794ac2f63f
> commit: 2a56c462fe5a2ee61d38e2d7b772bee56115a00c [11/15] OPP: Fix required_opp_tables for multiple genpds using same table
> config: i386-randconfig-141-20240517 (https://download.01.org/0day-ci/archive/20240518/202405180016.4fbn86bm-lkp@intel.com/config)
> compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> | Closes: https://lore.kernel.org/r/202405180016.4fbn86bm-lkp@intel.com/
> 
> New smatch warnings:
> drivers/opp/core.c:2447 _opp_attach_genpd() warn: missing unwind goto?

Sent a fix. Thanks.

-- 
viresh

