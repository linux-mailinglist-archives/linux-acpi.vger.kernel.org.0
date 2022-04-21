Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A495509886
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Apr 2022 09:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385045AbiDUGsM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 21 Apr 2022 02:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385388AbiDUGrr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Apr 2022 02:47:47 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15804140C1
        for <linux-acpi@vger.kernel.org>; Wed, 20 Apr 2022 23:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=u9m/ScaeuMkr2yZLzOYRZwm82E
        3prkfNvcGm2r6bjpfGTp8OCzKoRmO02oX8SMFnDbMqrcKD1TN14EKJTy71YlSzv8QXLNQagqBQXyk
        uJEBs1rBdVO3IOckgmhGgFQyQA2RswCmVN8OGX9Y3rK0YXyCjdZHFAWyQHsJfofk6UZ4FZUVZe2IQ
        R0hsEKmMQM9opI/yPkhOQ7iSzWPKAkylVuZqMK6a6N/QCvb/uEYfKbHZSJ/KKbjXiYZBOYVjWJ+Hl
        fbrAyMC5cELr3I8D7J6rwgmDaj6NO+h4LJdY8a28fHjUGjyJHQZiblFZIBmtQjdM8KnbOvL1tpTSQ
        VNbR6Y/Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nhQYZ-00Boo3-8F; Thu, 21 Apr 2022 06:44:47 +0000
Date:   Wed, 20 Apr 2022 23:44:47 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux-foundation.org, linuxarm@huawei.com,
        lorenzo.pieralisi@arm.com, joro@8bytes.org, robin.murphy@arm.com,
        will@kernel.org, wanghuiqiang@huawei.com, guohanjun@huawei.com,
        steven.price@arm.com, Sami.Mujawar@arm.com, jon@solid-run.com,
        eric.auger@redhat.com, laurentiu.tudor@nxp.com, hch@infradead.org
Subject: Re: [PATCH v10 3/9] ACPI/IORT: Provide a generic helper to retrieve
 reserve regions
Message-ID: <YmD9X+BWI9tfHub1@infradead.org>
References: <20220420164836.1181-1-shameerali.kolothum.thodi@huawei.com>
 <20220420164836.1181-4-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420164836.1181-4-shameerali.kolothum.thodi@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
