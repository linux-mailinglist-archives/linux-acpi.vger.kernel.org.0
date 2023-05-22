Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D441170B7C3
	for <lists+linux-acpi@lfdr.de>; Mon, 22 May 2023 10:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbjEVIg2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 22 May 2023 04:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjEVIg1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 22 May 2023 04:36:27 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77620B7
        for <linux-acpi@vger.kernel.org>; Mon, 22 May 2023 01:36:26 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34M7BCRf014700;
        Mon, 22 May 2023 08:35:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=5ROhQBkArFep+UPB9mqu4wVSvS6XVSUEou8A5Q3oEu4=;
 b=hoAhjWZUYBGB2tlR/O6LDUBgSgkiV1cAexCofKUQqWJvZ/55YegucyINmZCg+h+32lsP
 z15QJzCEeFFOKQYi+IuF+jJlbN2Yj3z631n1NMcDziXdBsXC43Pp+waF845ciOMdAV28
 nPd7p1i5ib3+0Y1WJSdXaUeiIETm08glJa5c9J/7vVlfPoYpz6XZTn5/C5dNFia1aL8C
 jVx9fQ31nRFWRx6JIizeVuHrOTlhJdlwNe4w7Y5uFJlrYf1uJNjHotKg+QFmJhs4ckK0
 2oyvFVACoJ9SZEIJEt9qPN1AoEF+u//X45hnvvCvUrj2xPAqoqw65xMXUHAgO8CPessa UQ== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qqgbq5ny7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 May 2023 08:35:55 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34M6Xa1V027512;
        Mon, 22 May 2023 08:35:53 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3qppcf0qdk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 May 2023 08:35:53 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34M8Zoed7406294
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 May 2023 08:35:50 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8400C20043;
        Mon, 22 May 2023 08:35:50 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BAB7320040;
        Mon, 22 May 2023 08:35:49 +0000 (GMT)
Received: from [9.171.23.45] (unknown [9.171.23.45])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 22 May 2023 08:35:49 +0000 (GMT)
Message-ID: <8c00a455c0ff008634aad331d5d85584697f02ff.camel@linux.ibm.com>
Subject: Re: [PATCH v2 04/10] iommu: Simplify the
 __iommu_group_remove_device() flow
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>
Date:   Mon, 22 May 2023 10:35:49 +0200
In-Reply-To: <4-v2-3c3bb7aa6e48+1916b-iommu_probe_jgg@nvidia.com>
References: <4-v2-3c3bb7aa6e48+1916b-iommu_probe_jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 (3.48.1-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nQp6YTRyXjfQ4VJNyzcy_PAXxT0P4p_m
X-Proofpoint-ORIG-GUID: nQp6YTRyXjfQ4VJNyzcy_PAXxT0P4p_m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-22_05,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 phishscore=0 clxscore=1011 impostorscore=0 adultscore=0 mlxlogscore=999
 lowpriorityscore=0 mlxscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305220068
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, 2023-05-19 at 15:42 -0300, Jason Gunthorpe wrote:
> Instead of returning the struct group_device and then later freeing it, d=
o
> the entire free under the group->mutex and defer only putting the
> iommu_group.
>=20
> It is safe to remove the sysfs_links and free memory while holding that
> mutex.
>=20
> Move the sanity assert of the group status into
> __iommu_group_free_device().
>=20
> The next patch will improve upon this and consolidate the group put and
> the mutex into __iommu_group_remove_device().
>=20
> __iommu_group_free_device() is close to being the paired undo of
> iommu_group_add_device(), following patches will improve on that.
>=20
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/iommu.c | 83 ++++++++++++++++++++-----------------------
>  1 file changed, 39 insertions(+), 44 deletions(-)
>=20
---8<---
> +
> +/*
> + * Remove the iommu_group from the struct device. The attached group mus=
t be put
> + * by the caller after releaseing the group->mutex.
> + */
> +static void __iommu_group_remove_device(struct device *dev)
> +{
> +	struct iommu_group *group =3D dev->iommu_group;
> +	struct group_device *device;
> +
> +	lockdep_assert_held(&group->mutex);
> +	for_each_group_device(group, device) {
> +		if (device->dev !=3D dev)
> +			continue;
> +
> +		list_del(&device->list);

for_each_group_device() uses list_for_each_entry() but here you are
deleting from the list, don't we need a ..._safe() variant then?

> +		__iommu_group_free_device(group, device);
> +		/* Caller must put iommu_group */
> +		return;
> +	}
> +	WARN(true, "Corrupted iommu_group device_list");
>  }
>=20
---8<---
