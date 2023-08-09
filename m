Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D57587752F1
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Aug 2023 08:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjHIGh1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 9 Aug 2023 02:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHIGh0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Aug 2023 02:37:26 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C605A10CF
        for <linux-acpi@vger.kernel.org>; Tue,  8 Aug 2023 23:37:25 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id a1e0cc1a2514c-79b191089a3so1150148241.3
        for <linux-acpi@vger.kernel.org>; Tue, 08 Aug 2023 23:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691563045; x=1692167845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VXim2MymBxTflefzDOZEMnQ/WX10EzI7OaoHPJ5kCOg=;
        b=eTdOW3qToxUPAT6ev8xRADd/Y8t00wIqEDMXLZM/aliVEHzifmLaPqxvuMk1K+9Z28
         QjTx2EuHFt8znaqPNZYEfI3N3LSynhT5mfZj/f8aLJHl7986YPAcWQmqmV33ruoMEI4F
         Wy/HkHqqPAbnQkSrM2kcFzvABsJarpOJtyBmI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691563045; x=1692167845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VXim2MymBxTflefzDOZEMnQ/WX10EzI7OaoHPJ5kCOg=;
        b=TtYjGk6L0OESJ8ReapjS0eLDImR1hO0CAQhmGUDzrS6opLwWCvfp++YS3NdzEGw3rn
         1G/p+Zr4Y1eJO26+5thtrNVo6U9SHV9VEFQlCVrMPz11DhhXN/SoqSNm27KGBukL1e89
         5u07EEGcmwUMfuzhU4JtgeFzynvImH7Vp9rmZRTxIM98BhC4Yx9iNcWbwm31QDZWWwC+
         V5ENHDKNThTYERAX/6JWjU9sq4TDpipBrJbtt9MSNicrZb7KRZbff1pMfyKci9vTjia/
         xOAk0r0/qRoVUychUm+hgL7Pcu9g68GpKwV4/qz5fa/2y53NmXTlI4+nYXaXHgDfEQ6q
         h3sg==
X-Gm-Message-State: AOJu0Yzj607GmWNdKTU1e0cXZBP68IB7ntnONq971vq+3dqdVmIlHJ+a
        TJql2urVb74/Hu5sCVyCgZ6cLIvMyMjwQEBf3TA+Ww==
X-Google-Smtp-Source: AGHT+IGz/4D96cU9ja2eYEBssih1gH0rRpSOd+CLJoi0SzNs4SxPmgwff00GMCkK5WIE2enVwuqkKwI69LXZcGTKcJI=
X-Received: by 2002:a67:f3d3:0:b0:443:a4d2:86b9 with SMTP id
 j19-20020a67f3d3000000b00443a4d286b9mr1919249vsn.0.1691563044929; Tue, 08 Aug
 2023 23:37:24 -0700 (PDT)
MIME-Version: 1.0
References: <0-v1-8612b9ef48da+333-iommu_group_locking2_jgg@nvidia.com>
In-Reply-To: <0-v1-8612b9ef48da+333-iommu_group_locking2_jgg@nvidia.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Wed, 9 Aug 2023 14:37:13 +0800
Message-ID: <CAGXv+5GL33D-uZ9MeZbvUuy5aSntOSfk3KaYMa1pFarydp=Vjg@mail.gmail.com>
Subject: Re: [PATCH 0/3] Fix device_lock deadlock on two probe() paths
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Aug 9, 2023 at 1:27=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wro=
te:
>
> I missed two paths where __iommu_probe_device() can be called while
> already holding the device_lock() for the device that is to be probed.
>
> This causes a deadlock because __iommu_probe_device() will attempt to
> re-acquire the lock.
>
> Organize things so that these two paths can re-use the existing already
> held device_lock by marking the call chains based on if the lock is held
> or not.
>
> This is an incremental on top of Joerg's next, but it could also be handl=
ed by
> respinning the last patch in that series. Please let me know.
>
> Jason Gunthorpe (3):
>   iommu: Provide iommu_probe_device_locked()
>   iommu: Pass in the iommu_device to probe for in bus_iommu_probe()
>   iommu: Do not attempt to re-lock the iommu device when probing

Tested-by: Chen-Yu Tsai <wenst@chromium.org>

Thank you for coming up with fixes so quickly.
