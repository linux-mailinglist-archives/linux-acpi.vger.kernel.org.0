Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10E9577615C
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Aug 2023 15:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbjHINig (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 9 Aug 2023 09:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbjHINif (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Aug 2023 09:38:35 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B942126
        for <linux-acpi@vger.kernel.org>; Wed,  9 Aug 2023 06:38:33 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230809133831euoutp0230f1bbab72cc073e8ac95e524f5efc9f~5uptb5gPa2155921559euoutp02b
        for <linux-acpi@vger.kernel.org>; Wed,  9 Aug 2023 13:38:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230809133831euoutp0230f1bbab72cc073e8ac95e524f5efc9f~5uptb5gPa2155921559euoutp02b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1691588311;
        bh=SKqPzDFlrkcCcHmSuqmh4kcm811YUbeL2qHu7n5US7s=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=craY2OV6na1qz6M8TKOSEWbIrFM6PrT80vKkh7Utc3rSi5a3hBPS7t22ClnqLN4Lb
         7flARHhk2FYwULGo3x1scVGh3cK9zOhRMVwMI/aWgRoHNU+JbNf8vNzS3xf+BHHChf
         /5Udo4lYI2otABN3WmJx5oQxyZpZ8z3K2NYZ0YQk=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230809133831eucas1p21e51d486ac97f504bff8f142dbb32c96~5uptJ1Qcs0148701487eucas1p2O;
        Wed,  9 Aug 2023 13:38:31 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 04.72.11320.7D693D46; Wed,  9
        Aug 2023 14:38:31 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230809133830eucas1p287639c948bc3fde51b529e2d562ab010~5ups1uaAd0149901499eucas1p2x;
        Wed,  9 Aug 2023 13:38:30 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230809133830eusmtrp25cfecda9d6ef6858d9a74af399a96146~5upszl5WK1005010050eusmtrp2I;
        Wed,  9 Aug 2023 13:38:30 +0000 (GMT)
X-AuditID: cbfec7f4-97dff70000022c38-b1-64d396d7f811
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id F5.47.14344.6D693D46; Wed,  9
        Aug 2023 14:38:30 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230809133830eusmtip1103926a77f235a47fceb7cd7d51271f8~5upsG_1fr3234332343eusmtip1b;
        Wed,  9 Aug 2023 13:38:29 +0000 (GMT)
Message-ID: <4208251b-8822-9376-cbe3-572f362720c5@samsung.com>
Date:   Wed, 9 Aug 2023 15:38:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0)
        Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH 3/3] iommu: Do not attempt to re-lock the iommu device
 when probing
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "Tian, Kevin" <kevin.tian@intel.com>
Cc:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Joerg Roedel <joro@8bytes.org>, Len Brown <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Chen-Yu Tsai <wenst@chromium.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <ZNODeRzC+Rtkta1U@nvidia.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKKsWRmVeSWpSXmKPExsWy7djP87rXp11OMTh4lM1i88StbBa/vlhY
        XPm3h9Gic/YGdoulb7eyW+x8+JbNYvm+fkaLuV+mMlsc/PCE1WJG22VWi5Y7pg7cHk8OzmPy
        WDNvDaPH7IaLLB6L97xk8ti0qpPNY97JQI8Xm2cyevQ2v2Pz+LxJLoAzissmJTUnsyy1SN8u
        gSvjbU8jS8EJ7orPy3exNjD2c3YxcnJICJhIXLzVxtLFyMUhJLCCUeL0i/VQzhdGia5Z75gh
        nM+MEs+7nrPAtNw8tI0JIrEcqOXWClYI5yOjxKEZi1lBqngF7CSu9fUwgdgsAioSva132CHi
        ghInZz4BmyQqkCqx4/YEsHphgUiJoye6GEFsZgFxiVtP5oP1igh4Sax/+APsJmaBF0wSz7bP
        BmtmEzCU6HrbxQZicwpoSRzcv50NolleYvvbOWB3SwhM55Q4MXEr1N0uEi3d/5ghbGGJV8e3
        sEPYMhL/d85ngmhoZ5RY8Ps+lDOBUaLh+S1GiCpriTvnfgGt4ABaoSmxfpc+RNhR4lZvK1hY
        QoBP4sZbQYgj+CQmbZvODBHmlehoE4KoVpOYdXwd3NqDFy4xT2BUmoUULrOQ/D8LyTuzEPYu
        YGRZxSieWlqcm55abJSXWq5XnJhbXJqXrpecn7uJEZjSTv87/mUH4/JXH/UOMTJxMB5ilOBg
        VhLhtQ2+lCLEm5JYWZValB9fVJqTWnyIUZqDRUmcV9v2ZLKQQHpiSWp2ampBahFMlomDU6qB
        aaPXz+mn7TY8X/9E8p1e3Dd3V85rf902GhTvk1eZ9H93XfH+dx8yRd/b7POQsFo3Q7+l51/0
        UsdLIScZ820OnFm8Rrp+sRVP9s+5xj73jPxPyKg8CE3XbVvzMH7fg9P7dxtx6lcVn5jyb/2c
        //2VjXJvRdZ8lz/RwsSX/rZ2+cod03Mfb0oRtYgwYXc8tPJPfZ17cYLz55eS66JdtmT/2v5q
        17arnltet5UYcvvsaOgy9fh29pBGe/n/L8t1OdpsE5KMaj8JvVeu5zs/2efiDkOjk/t0c+YL
        Frnd/Le8KT98SY/sYg/7o7bifs1TtXh/au3O4nWpe/H16OT5p1PrKt1FePLmLudccXn/9/qo
        DiWW4oxEQy3mouJEABQTNrzYAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOIsWRmVeSWpSXmKPExsVy+t/xu7rXpl1OMXj/SNdi88StbBa/vlhY
        XPm3h9Gic/YGdoulb7eyW+x8+JbNYvm+fkaLuV+mMlsc/PCE1WJG22VWi5Y7pg7cHk8OzmPy
        WDNvDaPH7IaLLB6L97xk8ti0qpPNY97JQI8Xm2cyevQ2v2Pz+LxJLoAzSs+mKL+0JFUhI7+4
        xFYp2tDCSM/Q0kLPyMRSz9DYPNbKyFRJ384mJTUnsyy1SN8uQS/jbU8jS8EJ7orPy3exNjD2
        c3YxcnJICJhI3Dy0jamLkYtDSGApo8S3ydPYIRIyEienNbBC2MISf651sUEUvWeUuPuxAayI
        V8BO4lpfDxOIzSKgItHbegcqLihxcuYTFhBbVCBV4lfDLrBBwgKREkdPdDGC2MwC4hK3nswH
        6xUR8JJY//AHC8gCZoFXTBKnNt9ghNh2hkmicU832CQ2AUOJrrcgZ3BycApoSRzcv50NYpKZ
        RNdWmKnyEtvfzmGewCg0C8khs5AsnIWkZRaSlgWMLKsYRVJLi3PTc4uN9IoTc4tL89L1kvNz
        NzECY3jbsZ9bdjCufPVR7xAjEwfjIUYJDmYlEV7b4EspQrwpiZVVqUX58UWlOanFhxhNgaEx
        kVlKNDkfmETySuINzQxMDU3MLA1MLc2MlcR5PQs6EoUE0hNLUrNTUwtSi2D6mDg4pRqYFmo9
        mPP53Q+ehHK/9wfeO/x0FuZZdN5Hdub7hiWWmxyaJMRU4x/HRa64JaJ/YMmplxqsamZSDeZC
        lnpuMj8ioif6CnLOMA9PfHfztVbANvMV3LfMzqcV+SZeTSwJXudaL+YwaeazdTZRLuvzXl6J
        nrxu3XQvjc/3XV7tEj91OnJJiOJc10mr1y665SOgdTlu+bk9L0K5Tu5eITr90v6eT3kNN1e+
        uV3Umv63V+278oVOVfPZTu39K+0kv84Qnq6brnSxbM4blpPhL4z/XMn7LZ54dV5n4urtn4P3
        m++7e4X70JGXtjH/p/O4+5oxLrzx4yrnV/XJx22vpLkvO5IoOWfTwp0CU5hPSW/j6WCbekOJ
        pTgj0VCLuag4EQCwuXxNagMAAA==
X-CMS-MailID: 20230809133830eucas1p287639c948bc3fde51b529e2d562ab010
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230809121601eucas1p150499eaa6e5fa6aa998385b3fba70a5a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230809121601eucas1p150499eaa6e5fa6aa998385b3fba70a5a
References: <0-v1-8612b9ef48da+333-iommu_group_locking2_jgg@nvidia.com>
        <3-v1-8612b9ef48da+333-iommu_group_locking2_jgg@nvidia.com>
        <BN9PR11MB5276EA0632C6E65C83397B1A8C12A@BN9PR11MB5276.namprd11.prod.outlook.com>
        <CGME20230809121601eucas1p150499eaa6e5fa6aa998385b3fba70a5a@eucas1p1.samsung.com>
        <ZNODeRzC+Rtkta1U@nvidia.com>
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 09.08.2023 14:15, Jason Gunthorpe wrote:
> On Wed, Aug 09, 2023 at 04:01:42AM +0000, Tian, Kevin wrote:
>>> From: Jason Gunthorpe <jgg@nvidia.com>
>>> Sent: Wednesday, August 9, 2023 1:27 AM
>>>
>>> @@ -1800,11 +1801,18 @@ struct probe_iommu_args {
>>>   static int probe_iommu_group(struct device *dev, void *data)
>>>   {
>>>   	struct probe_iommu_args *args = data;
>>> +	bool need_lock;
>>>   	int ret;
>>>
>>> -	device_lock(dev);
>>> +	/* Probing the iommu itself is always done under the device_lock */
>>> +	need_lock = !args->iommu || args->iommu->hwdev != dev;
>>> +
>> is !args->iommu a valid case?
> Hmm, not any more, it used to happen in an earlier version
>   
>> btw probably a dumb question. Why do we continue to probe the
>> iommu device itself instead of skipping it? The group is a concept
>> for devices which require DMA protection from iommu instead of
>> for the iommu device itself...
> Yeah, that is how I originally did it, but since the locking appeared
> here I thought it would be safer to just continue to invoke probe as
> we have always done. I don't know for sure that there isn't some
> driver that relies on this for some reason.
>
> eg it might change the group layouts or something.

Well, I don't think that there is any driver doing such things, but the 
only way to check is simply change the behavior an wait for complaints.


Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

