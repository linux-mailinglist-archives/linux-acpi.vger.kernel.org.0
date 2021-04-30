Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA1536FB61
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Apr 2021 15:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbhD3NW7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 30 Apr 2021 09:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbhD3NW7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 30 Apr 2021 09:22:59 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2158FC06174A
        for <linux-acpi@vger.kernel.org>; Fri, 30 Apr 2021 06:22:10 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id h11so8830972pfn.0
        for <linux-acpi@vger.kernel.org>; Fri, 30 Apr 2021 06:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=c4lvSWuTZSCfgzGNwMBJ/MICQkH+/oOQe9GaSB2JKvc=;
        b=ntA8NL/YrCdSX64C57CZkMEZHge+WIPIXS5/v2E3pDqirV6xOI4utlaI4Lk/LHw+hq
         YaPnnV0TCDjDGca/PJgNMQs5HpEn5gjNSQfVTOgSFaGAEnCmgeqSVUoSW3dtXpGW3r18
         jDLNOXVWdAGT1ISL1wDcRrCBQ7wqbziu2hJScxaS3yHr2RqpUEVyVLRPpGGM4ih4WHbO
         /UdYSix2BuyTny6Iq2MD8I2194TLrnHDmYx2JOSQCbQ+2QdJWkdwcvr891BFthfV1Udp
         qmQLvP9FoyrFtXiUSHx8ZaZopHIX+r+VfUQScSBWdkLiJCqwTSVMeE0Amhh9h/pF9pBK
         RLew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=c4lvSWuTZSCfgzGNwMBJ/MICQkH+/oOQe9GaSB2JKvc=;
        b=d6itbCaBeA2zKWlqWELjbFlxQqU5SqQjkUc1uBvdw/2i7fVVkcWvhFh9FMHWS618hA
         gq1XpQnYUsHRSR3MrMqniKk2mMClKbduY5rT6p9wXayW3d0lPu/vbpJ81PcnjpjZ4suC
         FyKBZ6kkHgRLozJYW1fcbFeaWPNdLVmyJnqBhvrTXYRypv6bpmA46LN5QfK1FTNV+3A+
         b+LwLYENHk3Q1x5CfIv3SST3eGb30uNRQJpc9s3OSLn7hpInhaeR2jtzLsMTTH4TI9uC
         qY5R29e6SfQV1Uk085KrfoBWo7ie0UeU916qtgcwE3/PBEh+rSMCnfXBZkbA3h9i6fwB
         TteA==
X-Gm-Message-State: AOAM533RXL2Oyb/I0jobisJXcTvCCGGD8QTlsJRQWiwoYFVMMKOoUGFp
        r7KMZ1st4+Kjm6mB8pfvky0iDA==
X-Google-Smtp-Source: ABdhPJw9NnAzOfPvCBNS6sDgGiWKNKEIKD3YCEh28INJny1FACCtmRQEnNBHF4F164ZiAXocOphv5g==
X-Received: by 2002:a62:3486:0:b029:24c:34c0:3c7a with SMTP id b128-20020a6234860000b029024c34c03c7amr4798113pfa.36.1619788929656;
        Fri, 30 Apr 2021 06:22:09 -0700 (PDT)
Received: from dragon (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id f22sm2127701pfe.128.2021.04.30.06.22.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Apr 2021 06:22:09 -0700 (PDT)
Date:   Fri, 30 Apr 2021 21:22:04 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Erik Kaneda <erik.kaneda@intel.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Gordon Ross <gordon.w.ross@gmail.com>, Moore@dragon,
        Robert <robert.moore@intel.com>
Subject: Re: [RFT PATCH] ACPICA: Fix memory leak caused by _CID repair
 function
Message-ID: <20210430132203.GI15093@dragon>
References: <20210428225247.1701392-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210428225247.1701392-1-erik.kaneda@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Apr 28, 2021 at 03:52:47PM -0700, Erik Kaneda wrote:
> ACPICA commit 5fc4f4b87d6890d48d050ab279ed01f0132662ca
> 
> According to the ACPI spec, _CID returns a package containing
> hardware ID's. Each element of an ASL package contains a reference
> count from the parent package as well as the element itself.
> 
> Name (TEST, Package() {
>     "String object" // this package element has a reference count of 2
> })
> 
> A memory leak was caused in the _CID repair function because it did
> not decrement the reference count created by the package. Fix the
> memory leak by calling acpi_ut_remove_reference on _CID package elements
> that represent a hardware ID (_HID).
> 
> Link: https://github.com/acpica/acpica/commit/5fc4f4b8
> 
> Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>

Tested on Snapdragon laptops, and nothing seems broken.

Tested-by: Shawn Guo <shawn.guo@linaro.org>
