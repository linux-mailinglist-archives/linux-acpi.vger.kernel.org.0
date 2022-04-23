Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC32550C77F
	for <lists+linux-acpi@lfdr.de>; Sat, 23 Apr 2022 07:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232446AbiDWFRS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 23 Apr 2022 01:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiDWFRR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 23 Apr 2022 01:17:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B61A245473
        for <linux-acpi@vger.kernel.org>; Fri, 22 Apr 2022 22:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=Y0EJPD7yiCmLWdPGuJ8YAUfceJ
        Mq5ubxrNhPFtJoPEErymJg0nFe8CfNFEt+yyTHJkCG9meJzHfKtasV9VakPYK9uhG+swS+bIAlZSV
        qgdR6KNX5Kn1hsglVD7VDOmU/TSuB9EEYQXl1EsFybsoQQdUCYCN18H+oEs/wy8VzqdcgfHoII0kY
        eqyfN7h2UJKn/hlG17nq7It3zTudwhQgR7ycyuO3KrCqmWiqmKlJ3mPlmX+pAm/lSYGnE3tpdONcd
        Agiew2BujGErAMyMNE/bYGY+eI40xntlStFfYI3+pbv3aj/yBZnj5rIjHkGeWOnPLVcTuqDeacKAP
        xoML2XAQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ni869-003SOM-Kr; Sat, 23 Apr 2022 05:14:21 +0000
Date:   Fri, 22 Apr 2022 22:14:21 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux-foundation.org, linuxarm@huawei.com,
        lorenzo.pieralisi@arm.com, joro@8bytes.org, robin.murphy@arm.com,
        will@kernel.org, wanghuiqiang@huawei.com, guohanjun@huawei.com,
        steven.price@arm.com, Sami.Mujawar@arm.com, jon@solid-run.com,
        eric.auger@redhat.com, laurentiu.tudor@nxp.com, hch@infradead.org
Subject: Re: [PATCH v11 1/9] iommu: Introduce a callback to struct
 iommu_resv_region
Message-ID: <YmOLLX7we/kALRd6@infradead.org>
References: <20220422162907.1276-1-shameerali.kolothum.thodi@huawei.com>
 <20220422162907.1276-2-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422162907.1276-2-shameerali.kolothum.thodi@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
