Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0827B345C50
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Mar 2021 11:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbhCWKxp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 23 Mar 2021 06:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbhCWKxb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 23 Mar 2021 06:53:31 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B592C061574
        for <linux-acpi@vger.kernel.org>; Tue, 23 Mar 2021 03:53:29 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id e18so20282557wrt.6
        for <linux-acpi@vger.kernel.org>; Tue, 23 Mar 2021 03:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WGlnCIX+gPkt5saLRl1AO/eSfyQX4KhnrSrkJYnpgYY=;
        b=lIV8cb4KFfS7wkzFGd10vbdRrumERBd84XwjQG3DjbGuRdwbmikbg0jk61DgpoawxN
         BBl7QlKsTaJXnPCOF2y6MKlpThqG96Zmz81Yrp+FEZ6nTCt8av7uCsN5iwc29SpdsQSl
         EiW8j9VDV469niDRLYcAmzwI0D62kxpgUkue6nlgB7GxWnCpKMJp7zKfYmw4LCttdy0W
         G+gypPOTuKhWasizmui5cLDWk8ApZ/QXiji5JiDhmE2Nqmn2He3ID9hBKFsjODY4B8Q9
         b/M0eeC82xya4hZASNOjs2fKQtd+/3nIbS+1xCePGaJtlOEzWWikRqqdme5aVwM8jGf1
         rxZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WGlnCIX+gPkt5saLRl1AO/eSfyQX4KhnrSrkJYnpgYY=;
        b=c2rn0oQomYTJekzk/jmg5GfwymDabUTEgm7a+AIlaq308Yw4USQEXkaDIP27e6R38Q
         KQyJbBXYunJ7nbv1/qy0h5m66BXn51A4V44/Z+TtThQ2WTy1i/46KOgWQSbuAnwM1J/I
         r5s41JUkaO2nAadZP13xf7kkMiq3zUbW1YJWrykVJoRmikxBZcpUonZxxC6PvQA4sqFx
         XmdbeTLUvipWX7tD9IskByi+s7ZBhLgT+iYim2DRXgm40iE/RD8pT/azPsaWTJGsASqa
         3H47jYyPiRwpqQXVTU5qhy5WTq++Lvk74X/hdTR4hYeYsu63f5EerF/I5wkesvpz9zh+
         zVvg==
X-Gm-Message-State: AOAM532CoCzPwU2A+thSRPuyNTKbRpZdS6gkIeFuvpIn/79cafhYcv6W
        rE5mWMYD0YRa/+USLRBdbCEk1A==
X-Google-Smtp-Source: ABdhPJxsZ4rfGrv8Gu+78757z6bQt9fLbU/W53+clBFuohI6UOhnceZv0BUdjXF3LdKpnrW2LNNtVA==
X-Received: by 2002:a5d:4d01:: with SMTP id z1mr3253375wrt.133.1616496808336;
        Tue, 23 Mar 2021 03:53:28 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id z1sm23063818wru.95.2021.03.23.03.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 03:53:27 -0700 (PDT)
Date:   Tue, 23 Mar 2021 11:53:10 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     "Raj, Ashok" <ashok.raj@intel.com>
Cc:     joro@8bytes.org, will@kernel.org, vivek.gautam@arm.com,
        guohanjun@huawei.com, zhukeqian1@huawei.com,
        wangzhou1@hisilicon.com, linux-acpi@vger.kernel.org,
        zhangfei.gao@linaro.org, lenb@kernel.org,
        devicetree@vger.kernel.org, kevin.tian@intel.com,
        jacob.jun.pan@linux.intel.com, eric.auger@redhat.com,
        vdumpa@nvidia.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, rjw@rjwysocki.net,
        shameerali.kolothum.thodi@huawei.com,
        iommu@lists.linux-foundation.org, sudeep.holla@arm.com,
        robin.murphy@arm.com, linux-accelerators@lists.ozlabs.org,
        baolu.lu@linux.intel.com
Subject: Re: [PATCH v13 06/10] iommu: Add a page fault handler
Message-ID: <YFnIlrecY6nkq5pP@myrica>
References: <20210302092644.2553014-1-jean-philippe@linaro.org>
 <20210302092644.2553014-7-jean-philippe@linaro.org>
 <20210303055727.GF1914@otc-nc-03>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210303055727.GF1914@otc-nc-03>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Mar 02, 2021 at 09:57:27PM -0800, Raj, Ashok wrote:
> > +	ret = handle_mm_fault(vma, prm->addr, fault_flags, NULL);
> 
> Should we add a trace similar to trace_page_fault_user() or kernel in
> arch/x86/kernel/mm/fault.c 

Yes that would definitely be useful for debugging hardware and developping
applications. I can send a separate patch to add tracepoints here and in
the lower-level device fault path.

> or maybe add a perf_sw_event() for device faults? 

It does seem like that would fit well alongside the existing
PERF_COUNT_SW_PAGE_FAULTS, but I don't think it would be useful in
practice, because we can't provide a context for the event. Since we're
handling these faults remotely, the only way for a user to get IOPF events
is to enable them on all CPUs and all tasks. Tracepoints can have 'pasid'
and 'device' fields to identify an event, but the perf_sw_event wouldn't
have any useful metadata apart from the faulting address.

We could also add tracepoints on bind(), so users can get the PASID
obtained with the PID they care about and filter fault events based on
that.

I've been wondering about associating a PASID with a PID internally,
because we don't currently have anywhere to send SEGV signals for
unhandled page faults. But I think it would be best to notify the device
driver on unhandled fault and let them deal with it. They'll probably want
that information anyway.

Thanks,
Jean
