Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA9A38CB38
	for <lists+linux-acpi@lfdr.de>; Fri, 21 May 2021 18:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235247AbhEUQno (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 21 May 2021 12:43:44 -0400
Received: from mail-ot1-f42.google.com ([209.85.210.42]:37704 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233011AbhEUQno (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 21 May 2021 12:43:44 -0400
Received: by mail-ot1-f42.google.com with SMTP id v19-20020a0568301413b0290304f00e3d88so18571234otp.4
        for <linux-acpi@vger.kernel.org>; Fri, 21 May 2021 09:42:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3uXCrfwflbJMKyoizw7GA0q9AX1L5xvF35SZVzuv9E4=;
        b=JTvBr34auCRdLKDbp7IeZLAx7RAWCtCtJGrSXtGdIC2CqaUJkAlm0cfmhjWjXCNUct
         /R1MxGkBbhW69vmpM+UHz81EjUZaYVl5VTA+c+4RcSXIPi1fvye/t03BrrwmdHFTfVN9
         97aEBfsL7XoKOaKTyKQmus9hgHy3F2iSy5Aie7WstAkq8T1miHVxsS0xuVdwAuKFfgr+
         1/NoPj+qYqZFJRPsK6beGmPckuPuh0geiMT03sLy+tlvsSZwfokZ7kzqCcX+KD3Bq+Oy
         OtTTdpZ2hClM/k/KQL5O7FV4Uuxc0uhlu7ULddzcCTuUVjrlTNndZvbntg8Oa3qXerPy
         oLWw==
X-Gm-Message-State: AOAM533bTqOO2XSsofdsKM66Tme3EmQZDYOtK9FzDzyNpiNM8OTT4NEk
        TvYVWMR5Uo8LKb6bR6vSbV0eN9HTbwcAi/PQE8g=
X-Google-Smtp-Source: ABdhPJxMRGdanl17OARb7DCS+ZzT5O3FDRmB93dTJ9tk7kP4k3enbgZYDKI5OAoTefUFUucCuw/QaF5cCRW+/jQ33L4=
X-Received: by 2002:a9d:6c46:: with SMTP id g6mr8963159otq.260.1621615340788;
 Fri, 21 May 2021 09:42:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210423113836.3974972-1-jean-philippe@linaro.org> <20210423113836.3974972-3-jean-philippe@linaro.org>
In-Reply-To: <20210423113836.3974972-3-jean-philippe@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 21 May 2021 18:42:09 +0200
Message-ID: <CAJZ5v0j=vqv3aJb_eitOVtpxgU3j5_j5hKPzyTEeHxfo_5MXdQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] ACPI: Move IOMMU setup code out of IORT
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>,
        virtualization@lists.linux-foundation.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Eric Auger <eric.auger@redhat.com>, sebastien.boeuf@intel.com,
        Robin Murphy <robin.murphy@arm.com>, kevin.tian@intel.com,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Apr 23, 2021 at 1:57 PM Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:
>
> Some of the IOMMU setup code in IORT is fairly generic and can be reused
> by VIOT. Extract it from IORT.

Except that iort_iommu_configure_id() is not really generic AFAICS.
