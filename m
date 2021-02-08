Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75FB1312C1B
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Feb 2021 09:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbhBHIoI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 8 Feb 2021 03:44:08 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:37740 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbhBHIlB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 8 Feb 2021 03:41:01 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20210208084015euoutp02cc74e151842ae46570faa69f8ef20ca0~huQ74mgY62035220352euoutp02R
        for <linux-acpi@vger.kernel.org>; Mon,  8 Feb 2021 08:40:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20210208084015euoutp02cc74e151842ae46570faa69f8ef20ca0~huQ74mgY62035220352euoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1612773615;
        bh=KNOrNrL+72nponq8j81Mwa76MDVPefX2wsyg2rqCJ3k=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=OzPfFMgeKTqGebk3pGIZDzUyPBmOD5j9Md0WMrpEIJS6aKALJ+3XDOdho+g0So/+H
         hzxDA6ObV49y6yWSCqhqKj5PEnSTkXzaXyhopL4qTM8iQi4cqDX6dIqMyEmtAz0iPr
         jenzLxlqE1RROIhRdQlDINIpLD+u6SVLcfzR5+HI=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210208084015eucas1p2a79133d1a5611ec48bf32385b99c0d4c~huQ7fykwT2617926179eucas1p2m;
        Mon,  8 Feb 2021 08:40:15 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 53.0B.45488.EE8F0206; Mon,  8
        Feb 2021 08:40:15 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210208084014eucas1p2f462f219c6e46c6eaec2ae88c03c9507~huQ65A-6w2626126261eucas1p2M;
        Mon,  8 Feb 2021 08:40:14 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210208084014eusmtrp29991457435cf7013f14c44f4b49aab41~huQ63_fnl0368203682eusmtrp2Q;
        Mon,  8 Feb 2021 08:40:14 +0000 (GMT)
X-AuditID: cbfec7f5-c77ff7000000b1b0-eb-6020f8eef31b
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 15.36.21957.EE8F0206; Mon,  8
        Feb 2021 08:40:14 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210208084013eusmtip2d038ff27818d7ead02c16b59f934df21~huQ5xo5Ko3214432144eusmtip20;
        Mon,  8 Feb 2021 08:40:13 +0000 (GMT)
Subject: Re: [PATCH v4 0/8] Make fw_devlink=on more forgiving
To:     Saravana Kannan <saravanak@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Len Brown <lenb@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        kernel-team@android.com
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <7b486072-453d-a344-bdfc-dec58a35c8f5@samsung.com>
Date:   Mon, 8 Feb 2021 09:40:13 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0)
        Gecko/20100101 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210205222644.2357303-1-saravanak@google.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCJsWRmVeSWpSXmKPExsWy7djP87rvfygkGCxtYLR4cqCd0WL+kXOs
        FjPf/GezeHZrL5NF8+L1bBY7totYPN38mMli1hSg0M6Hb9kslu/rZ7T42HOP1WJh2xIWi8u7
        5rBZfO49wmixc85JVouLp1wt7p46ymYx98tUZovWvUfYLboO/WWz+HdtI4vF5k1AseNrwx3E
        Pbbt3sbq8f5GK7vHzll32T0WbCr1WLznJZPHplWdbB53ru1h83h37hy7x6HDHYwe++euYfdY
        3DeZ1WPF6u/sHp83yQXwRnHZpKTmZJalFunbJXBlLG7+xFJwk7Pi8rqjjA2MT9i7GDk5JARM
        JBad28rUxcjFISSwglHiycFF7BDOF0aJ7tULmCGcz4wSD37+ZINpOdH1lREisZxRYs7Jq1At
        Hxkl+k83MoNUCQvYSjSdXgLWLiKwhUVi4641YFuYBT4Bzer+xgpSxSZgKNH1tgtoLgcHr4Cd
        xLYVUSBhFgEVibW/pzGC2KICSRLLb/5hArF5BQQlTs58wgJicwrYSBx+8g5sGbOAvMT2t3Og
        bHGJW0/mg+2SEOjikrhypo8F4m4Xie+7DkLZwhKvjm+BBoGMxP+dMA3NjBIPz61lh3B6GCUu
        N81ghKiylrhz7hfYpcwCmhLrd+lDhB0lvvZOYQYJSwjwSdx4KwhxBJ/EpG3TocK8Eh1tQhDV
        ahKzjq+DW3vwwiXmCYxKs5C8NgvJO7OQvDMLYe8CRpZVjOKppcW56anFxnmp5XrFibnFpXnp
        esn5uZsYgQn39L/jX3cwrnj1Ue8QIxMH4yFGCQ5mJRHewE65BCHelMTKqtSi/Pii0pzU4kOM
        0hwsSuK8u7auiRcSSE8sSc1OTS1ILYLJMnFwSjUwxb3meeT1KbQ3aGPey+lt6168m+SQtHL7
        DF2+RO3vJgtDFy7u6Zy+SGUXf0Msm0lmwpZ7jyaycn7yOp5kIvl9O4vjTNUY1dvcc2I07q+V
        7vSwXdrG/VqtQNQsTStifcfdubeEMgv6Z+35Vt+afdWi1nPZU+Hbmt5LNkd+tZ/X/HXiKo7g
        98/enOM6otK4q/zgboMzx/c3mbCkSew8/onX5fy6L1fqjvyR/Ht0jf/iT5LPHC3mXw9eb3JB
        tMxjrkOuxwGVzVtL3nBHLM16O//rJSe7kny5K9Z5gWkR33KK1xYWqM1lYgp1feqceiPC9SGX
        o+B+qR+t3ukGuqurfT70micfPLtI/3DJV4l3cx4GK7EUZyQaajEXFScCABW41o0nBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGKsWRmVeSWpSXmKPExsVy+t/xe7rvfigkGMxaL2zx5EA7o8X8I+dY
        LWa++c9m8ezWXiaL5sXr2Sx2bBexeLr5MZPFrClAoZ0P37JZLN/Xz2jxseceq8XCtiUsFpd3
        zWGz+Nx7hNFi55yTrBYXT7la3D11lM1i7pepzBate4+wW3Qd+stm8e/aRhaLzZuAYsfXhjuI
        e2zbvY3V4/2NVnaPnbPusnss2FTqsXjPSyaPTas62TzuXNvD5vHu3Dl2j0OHOxg99s9dw+6x
        uG8yq8eK1d/ZPT5vkgvgjdKzKcovLUlVyMgvLrFVija0MNIztLTQMzKx1DM0No+1MjJV0rez
        SUnNySxLLdK3S9DLWNz8iaXgJmfF5XVHGRsYn7B3MXJySAiYSJzo+srYxcjFISSwlFFi+/om
        FoiEjMTJaQ2sELawxJ9rXWwQRe8ZJRbens4GkhAWsJVoOr2EGSQhIrCNRWLylW0sIA6zwCdG
        iWW7ITJCAv2MEneOzQObxSZgKNH1FmQWBwevgJ3EthVRIGEWARWJtb+nMYLYogJJEo9v3WcC
        sXkFBCVOznwCdhKngI3E4SfvmEFsZgEziXmbH0LZ8hLb386BssUlbj2ZzzSBUWgWkvZZSFpm
        IWmZhaRlASPLKkaR1NLi3PTcYkO94sTc4tK8dL3k/NxNjMAEs+3Yz807GOe9+qh3iJGJg/EQ
        owQHs5IIb2CnXIIQb0piZVVqUX58UWlOavEhRlOgfyYyS4km5wNTXF5JvKGZgamhiZmlgaml
        mbGSOO/WuWvihQTSE0tSs1NTC1KLYPqYODilGpg4aq5ncM+YvSbIvNmA+W7ROnfPD1tkfmhe
        FZVbXN7r+aG1vE/Walt21EWRvNdbH0w70S30UFhq/7OAK4vnPy3ravO2POSq+b7LPObRkg/y
        acd//9zj/3ySyKkrNTdTw+SXuUifm7pqkZ6BlN/qtqCbx51dUqzdPiz86zvdwlSBqazLWv3V
        9uOmRx8ybErReHX2jgOPTvmlXXsyTm1S+mx+6/yGSxONP1ssDlx57PCv58WZFlsuJ1quezrl
        6e7j13c1eE/c5LH8RZuRZrxC6Zp38Uk3IkP3LF+xLZk7z7mab04Iq1vWC9WyfcYdNmc02B+p
        PsrVavdSZ0vZsPbV4v1+B+ff3xDxz7jrderN91dWK7EUZyQaajEXFScCANPuL3K5AwAA
X-CMS-MailID: 20210208084014eucas1p2f462f219c6e46c6eaec2ae88c03c9507
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20210205222651eucas1p28ef87073dea33c1c5224c14aa203bec5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20210205222651eucas1p28ef87073dea33c1c5224c14aa203bec5
References: <CGME20210205222651eucas1p28ef87073dea33c1c5224c14aa203bec5@eucas1p2.samsung.com>
        <20210205222644.2357303-1-saravanak@google.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Saravana,

On 05.02.2021 23:26, Saravana Kannan wrote:
> There are a lot of devices/drivers where they never have a struct device
> created for them or the driver initializes the hardware without ever
> binding to the struct device.
>
> This series is intended to avoid any boot regressions due to such
> devices/drivers when fw_devlink=on and also address the handling of
> optional suppliers.
>
> Patch 1 and 2 addresses the issue of firmware nodes that look like
> they'll have struct devices created for them, but will never actually
> have struct devices added for them. For example, DT nodes with a
> compatible property that don't have devices added for them.
>
> Patch 3 and 4 allow for handling optional DT bindings.
>
> Patch 5 sets up a generic API to handle drivers that never bind with
> their devices.
>
> Patch 6 through 8 update different frameworks to use the new API.

This patchset fixes probing issue observed on various Exynos based 
boards even with commit c09a3e6c97f0 ("soc: samsung: pm_domains: Convert 
to regular platform driver") reverted. Thanks!

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

Best regards

-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

