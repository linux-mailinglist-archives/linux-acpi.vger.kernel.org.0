Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A97BB1DCAB1
	for <lists+linux-acpi@lfdr.de>; Thu, 21 May 2020 12:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbgEUKJU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 21 May 2020 06:09:20 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39125 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbgEUKJU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 21 May 2020 06:09:20 -0400
Received: by mail-ot1-f68.google.com with SMTP id d7so5074570ote.6;
        Thu, 21 May 2020 03:09:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G6uQ8wnJmvD0mCIxvSrLQEXOd88ErMmS6CZ4aU3Nlj8=;
        b=i0FngIHW28ryo4MnEe6Y64DC7B3os+iQijzKHA22cFFtMq2Kmgsuu4Qq8kSHYJlVA7
         kY1V68FlhBGA6wXdNMRD7LFjdImjeUqGU/j2kH9ChXVdoea9z1DB8SK7ChHIrpy799O3
         9X8qlxFY4DsXRkghC+v+SBnyz8yX5GYcmATvXWKcTpSO8OYasW5t4b29iarRVLN2mAPl
         gZBpnfTN7NM9++RRkr7lZFhqqwgHYWWZKmFrym0zqehU01i3dK2U2Fw45Ds1T7tNtDUm
         p9i+we/93cBEsnVstRWvA5+0p+cNeKQ3P0M+tMRPGZV7EHWTqur+8ABtbQGDjipETg5N
         rMbA==
X-Gm-Message-State: AOAM530QDrORjZK3WYg/BaGfRvRWc2cFmzmYTplx+5ZZGygt5BRvmGS6
        PyeNs4VKaXcjbEZFDib3etHvv8b73rmeq33h4Z8=
X-Google-Smtp-Source: ABdhPJyPc7hILdCy2TcwrTUlHqZoto6E7vyja1AYNUn8qxZ/9DF+Bg7jGF0CQVPaPA9xPy/Pgu0YubKNamYfV+Zm8+I=
X-Received: by 2002:a9d:6c0f:: with SMTP id f15mr4683768otq.118.1590055759914;
 Thu, 21 May 2020 03:09:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200520213108.944764-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20200520213108.944764-1-srinivas.pandruvada@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 21 May 2020 12:09:06 +0200
Message-ID: <CAJZ5v0iPq3_RSTKRpGGiM0gEZLV5J77RKg_q_YdDB0yx4RSk6A@mail.gmail.com>
Subject: Re: [UPDATE][PATCH] ACPI / DPTF: Add additional attributes to power
 participant driver
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, May 20, 2020 at 11:31 PM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> Add two additional attributes to the existing power participant driver:
> rest_of_platform_power_mw: (RO) Shows the rest of worst case platform
> power in mW. This will help in power distribution to SoC and rest of the
> system. For example on a test system, this value is 2.5W with a 15W TDP
> SoC. Based on the adapter rating (adapter_rating_mw), user space
> software can decide on proper power allocation to SoC to improve
> short term performance via powercap/RAPL interface.

OK, so "the rest" here means "that part outside of the SoC" IIUC.

So it would be good to spell this out in the description of the
attribute in the ABI documentation.
