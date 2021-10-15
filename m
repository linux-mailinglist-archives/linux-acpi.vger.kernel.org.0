Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B89842FE71
	for <lists+linux-acpi@lfdr.de>; Sat, 16 Oct 2021 00:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243412AbhJOW73 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 15 Oct 2021 18:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243411AbhJOW73 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 15 Oct 2021 18:59:29 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36250C061762
        for <linux-acpi@vger.kernel.org>; Fri, 15 Oct 2021 15:57:22 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id l6so7263950plh.9
        for <linux-acpi@vger.kernel.org>; Fri, 15 Oct 2021 15:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3MWGSo8J4w0RXdtVwqVMm4uYTHYEHoeo+tcCsWTKSxY=;
        b=VZHeZzCY3PL4avtmU8lGuY1CvtpVh+tipHevkUmcXAteh4Dobxc3LNJKbXfdW3Afeg
         0ZGUGU++NEpP/uTKsyiQaARblf1QCbYOWBGVQCSR+AvKnRxlDtxiRMQHet5qfZ5qYPWg
         qDV2tH/ubCcZwygo9bw+twYt/FIwJZ8hDUEMMhTlypPSwAAAmCj1UlqGNeiYwXNOUm4p
         9n1azARmndnl/R2ZbOht6441KMS/w5CruDP6RlKoE4LUd5rMCik3biKxV6xjY95Oteys
         Pkm4ZLzJD9gtSDKC3l8IArbE8CrsHWDKy6jJ3m9NijRIN69QLbSu58a5bwH0Gf+dqGWq
         VFYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3MWGSo8J4w0RXdtVwqVMm4uYTHYEHoeo+tcCsWTKSxY=;
        b=cX3qDs+YwcceRcYdboO6vhOmty8zp8shyX/v1Z7ycL+nxtXhl3H348t5jMAbErL8q8
         QRVKIJ4T8AevXQx5ScT9JHqUvQjFYP18XETkydNGxe5qRadTSaUHwXSnc6utxXk7ynp8
         8/P3dWBguqrrJsI7oGunbGYBOjybFvcbIMtnkmfpGu3UjoNVZtxV2VTz3dPcJNAnp74S
         5yyYI6qajrtXT1A+T4b6Ry6nEdEn+p1hs3W5IrkZr05gOB8g7JokLTLcB7EZaEIJ6Ywz
         uKyFHFhE30F4wx92fHSSybflN+wuVF9AJkQowHnpBXMNEO2NT0qufbRtJogAf8mJUZOe
         NizQ==
X-Gm-Message-State: AOAM533kqcPx4SKwEPlQmvDR5lMoLiU9K9zUdHfeNMI2pOEQuQZUDxNZ
        fM6bYoF9p0XmchDau+aJAnCBhfb9VGK8sA==
X-Google-Smtp-Source: ABdhPJzDiTg12tYXR/PBHuS6tQb0K8WgqbJknwYLtFfXcCkEwyvPA0Aa3zGr1lqiSa8BFBqwmi26dg==
X-Received: by 2002:a17:902:ed0b:b0:13f:4318:491a with SMTP id b11-20020a170902ed0b00b0013f4318491amr13483327pld.4.1634338641488;
        Fri, 15 Oct 2021 15:57:21 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id x15sm5665489pgo.48.2021.10.15.15.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 15:57:21 -0700 (PDT)
Date:   Fri, 15 Oct 2021 22:57:17 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Tony Luck <tony.luck@intel.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        naoya.horiguchi@nec.com, Andrew Morton <akpm@linux-foundation.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Cathy Zhang <cathy.zhang@intel.com>, linux-sgx@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-mm@kvack.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: Re: [PATCH v9 1/7] x86/sgx: Add new sgx_epc_page flag bit to mark
 in-use pages
Message-ID: <YWoHTR8D7M8sEUpZ@google.com>
References: <20211001164724.220532-1-tony.luck@intel.com>
 <20211011185924.374213-1-tony.luck@intel.com>
 <20211011185924.374213-2-tony.luck@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211011185924.374213-2-tony.luck@intel.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Oct 11, 2021, Tony Luck wrote:
> SGX EPC pages go through the following life cycle:
> 
>         DIRTY ---> FREE ---> IN-USE --\
>                     ^                 |
>                     \-----------------/
> 
> Recovery action for poison for a DIRTY or FREE page is simple. Just
> make sure never to allocate the page. IN-USE pages need some extra
> handling.
> 
> Add a new flag bit SGX_EPC_PAGE_IN_USE that is set when a page
> is allocated and cleared when the page is freed.
> 
> Notes:
> 
> 1) These transitions are made while holding the node->lock so that
>    future code that checks the flags while holding the node->lock
>    can be sure that if the SGX_EPC_PAGE_IN_USE bit is set, then the
>    page is on the free list.
> 
> 2) Initially while the pages are on the dirty list the
>    SGX_EPC_PAGE_IN_USE bit is set.

This needs to state _why_ pages are marked as IN_USE from the get-go.  Ignoring
the "Notes", the whole changelog clearly states the the DIRTY state does _not_
require special handling, but then "Add SGX infrastructure to recover from poison"
goes and relies on it being set.

Alternatively, why not invert it and have SGX_EPC_PAGE_FREE?  That would have
clear semantics, the poison recovery code wouldn't have to assume that !flags
means "free", and the whole changelog becomes:

  Add a flag to explicitly track whether or not an EPC page is on a free list,
  memory failure recovery code needs to be able to detect if a poisoned page is
  free so that recovery can know if it's safe to "steal" the page.
