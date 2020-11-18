Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE0D92B7831
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Nov 2020 09:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725747AbgKRIIR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 18 Nov 2020 03:08:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbgKRIIQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 18 Nov 2020 03:08:16 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FCDBC0613D4
        for <linux-acpi@vger.kernel.org>; Wed, 18 Nov 2020 00:08:16 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id l5so973568edq.11
        for <linux-acpi@vger.kernel.org>; Wed, 18 Nov 2020 00:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MYkzksRNaGbOMgyJtFrKrhjpOwtjgLuKKLI9H1meENs=;
        b=xCWG2WDkXGUHEmmvlIEXs8mX9u3sb6FB0q9LFul6OKzhcg+CIPpbHyWVJyUIcZ6U0c
         CxzCSvsRY1fmsdf7hUe3PrzVMR4XzcBUH5/oDkRiRzgCDh1l3MGg9f7qpopJPDhA/Osf
         naXIzRtC+tCcAsimW4BCW/g1+nTYFw7Px93SotOJsq6n0lSPMi1qM3+8nb320uD64Ba8
         gLMznJOGDpF+y5CXx6brPuOqhhmOYYTNKbiw7OmMCngWtim6jtwlUlja+b94KEBDE01Z
         cClj/K8TpXVCCPjufmUZeja80w0hx/6KOG/M8vvoGE9/WY1lxBvSZ/eKf0rV7Sw9spuE
         MEzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MYkzksRNaGbOMgyJtFrKrhjpOwtjgLuKKLI9H1meENs=;
        b=YS/c21vJco8IFnjS5OJ6g9IDrICklmIFWFl5aRrqv7GrHgR4nCOAXAkcgzcA578OV/
         JB/qo1TjV3VfP/DXjYkjekNgcjuLSsXJEepsjpOVPtKN4jprBO9PrP1RqmW3bEq+KQKH
         UkrquqiKh2DFoEcEBjowNpjVgoIFmOE7oh0BEqRmLlWHzwg2uIN7KRbmaH4ZAftclmVO
         ajB67tOCeKT72D16aoA4yTE5xPg1fZnGbrZT6p69WuAIx3uaZ6wRGzs9ck1AUHjsuT3E
         Y+ppCcz6MqBdakK5UQiGjfNJ+CrrzhQSHdnCvDsU6aN49NY3q2LdX0rAYnZ/BWB9shBI
         52vQ==
X-Gm-Message-State: AOAM53068g6/ki+n3+u/Vlq9gauAtUxYv7JPmsGa51LkJmGkhbikRbQk
        JJOXMKBPCmODJL3KzhKYvXoyjrBPwMBN+Rx/1MCzIDwvYMk=
X-Google-Smtp-Source: ABdhPJyIpjJgJazX4fTSFDsxCZTxH/xxyf4fTir1+gkSOwPp8hbM6quT/hXeCY699yN511XwzGCCUFGquOJ6Buwje7k=
X-Received: by 2002:a05:6402:144f:: with SMTP id d15mr25196770edx.300.1605686895096;
 Wed, 18 Nov 2020 00:08:15 -0800 (PST)
MIME-Version: 1.0
References: <20201118073517.1884-1-thunder.leizhen@huawei.com>
In-Reply-To: <20201118073517.1884-1-thunder.leizhen@huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 18 Nov 2020 00:08:03 -0800
Message-ID: <CAPcyv4iECY-XoJ=jhARDDqjv-j8fnOUiKxB9Z+M5J+kMoeeWhA@mail.gmail.com>
Subject: Re: [PATCH 1/1] ACPI/nfit: avoid accessing uninitialized memory in acpi_nfit_ctl()
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-acpi <linux-acpi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Nov 17, 2020 at 11:36 PM Zhen Lei <thunder.leizhen@huawei.com> wrote:
>
> The ACPI_ALLOCATE() does not zero the "buf", so when the condition
> "integer->type != ACPI_TYPE_INTEGER" in int_to_buf() is met, the result
> is unpredictable in acpi_nfit_ctl().
>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

Looks good to me.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

I'll pick this up.
