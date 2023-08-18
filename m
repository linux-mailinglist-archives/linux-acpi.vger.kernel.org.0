Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1012A7812F5
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Aug 2023 20:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359123AbjHRShr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 18 Aug 2023 14:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379471AbjHRShp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Aug 2023 14:37:45 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37CDE3C3F
        for <linux-acpi@vger.kernel.org>; Fri, 18 Aug 2023 11:37:44 -0700 (PDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37IIbCPT030560;
        Fri, 18 Aug 2023 18:37:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=EXIi0eK12ai89YFTLn4ywUx2yW7twMKUH+DjVC8xJjU=;
 b=eju15apjYlNxCNz8y+YbNRWTDI39MtGeoZraAJtR3M0/xqtL+O7K6JGenAwRBcNncS4U
 7RSUgem65mKMeo20aQEUk5t2y0X2hBJyewmloTysJVaSkm59QJEI2G07AAWVOBIPJ6e7
 TI500xBn1dv3A4JbwixNWYdkpVfFEjO3l4Tcx3B8hv0TW05THv6KpSnFJTyz4Q43PYh4
 4sBd87X66F/n17xJZeulY0xDnyJSE/8hrAA/YtdEkVmabbJt8c/t3xXCz0H2NM/v+4N4
 biKk87WWc2MNzTRSGTeJKzhNToFP42ERWTlfFAw3Sx9MMyyr1OQviacHlO/aTyHo6TpL Ig== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sjdy0r265-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Aug 2023 18:37:14 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37IHu4cb018848;
        Fri, 18 Aug 2023 18:32:19 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3seq428k0j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Aug 2023 18:32:19 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
        by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37IIWI8t7799324
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Aug 2023 18:32:18 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 935535803F;
        Fri, 18 Aug 2023 18:32:18 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 90E8258056;
        Fri, 18 Aug 2023 18:32:17 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown [9.61.79.45])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 18 Aug 2023 18:32:17 +0000 (GMT)
Message-ID: <6ad5408dbe7acee4c83b7e9466c21f326f08b9b6.camel@linux.ibm.com>
Subject: Re: [PATCH v2 0/4] Fix device_lock deadlock on two probe() paths
From:   Eric Farman <farman@linux.ibm.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Joerg Roedel <jroedel@suse.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 18 Aug 2023 14:32:17 -0400
In-Reply-To: <ZN+1UktCwqTu53FI@nvidia.com>
References: <CGME20230809144403eucas1p1345aec6ec34440f1794594426e0402ab@eucas1p1.samsung.com>
         <0-v2-d2762acaf50a+16d-iommu_group_locking2_jgg@nvidia.com>
         <d090f196-a5c2-b188-31bf-e42553d8d251@samsung.com>
         <ZN5n7GnlrTS6s5Yg@nvidia.com> <ZN-UpDFHab0vGuXp@suse.de>
         <ZN+XE7dk04f2C3D7@nvidia.com>
         <bff750f47b326c7c0066f1debc5411a8208a128c.camel@linux.ibm.com>
         <ZN+1UktCwqTu53FI@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: x2OwDuS7gfQcZE6cJ2WYbd9bYpJ05aYo
X-Proofpoint-GUID: x2OwDuS7gfQcZE6cJ2WYbd9bYpJ05aYo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-18_23,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 clxscore=1015 bulkscore=0
 phishscore=0 impostorscore=0 mlxscore=0 priorityscore=1501 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308180170
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, 2023-08-18 at 15:15 -0300, Jason Gunthorpe wrote:
> On Fri, Aug 18, 2023 at 02:00:21PM -0400, Eric Farman wrote:
>=20
> > Well, I'm trying to chase down an apparent deadlock in the mdev
> > cases
> > that is introduced with the commit [1] blamed by these fixes. Seems
> > that when iommu_group_{add|remove}_device gets called out of vfio
> > (for
> > example, vfio-ap or -ccw), the device lock is already held so
> > attempting to get it again isn't going to go well.
>=20
> Oh, yes. Thankfully due to all the recent cleanup there is now only
> one caller of iommu_group_add_device() - VFIO and only on the
> vfio_register_emulated_iommu_dev() path.
>=20
> All those callers are under mdev probe callbacks so they all must
> have
> the device lock held. iommu_group_remove_device is the same. Simple
> fix to just assert the device lock is held.

Agreed.

>=20
> > I'm puzzled why lockdep isn't shouting over this for me, so I added
> > a
> > lockdep_assert_not_held() in those paths to get a proper callchain:
>=20
> The driver core mostly disables lockdep on the device_lock() :(

Ah, TIL. Thanks!

>=20
> Does this work for you?

Yup, for both -ap and -ccw devices that I have handy. Thanks for the
quick turnaround!

Thanks,
Eric

>=20
> Thanks,
> Jason
>=20
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 18162049bd2294..1f58bfacb47951 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1166,12 +1166,11 @@ int iommu_group_add_device(struct iommu_group
> *group, struct device *dev)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct group_device *gdev=
;
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0device_lock(dev);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0device_lock_assert(dev);
> +
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0gdev =3D iommu_group_allo=
c_device(group, dev);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (IS_ERR(gdev)) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0device_unlock(dev);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (IS_ERR(gdev))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return PTR_ERR(gdev);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0iommu_group_ref_get(group=
);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev->iommu_group =3D grou=
p;
> @@ -1179,7 +1178,6 @@ int iommu_group_add_device(struct iommu_group
> *group, struct device *dev)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mutex_lock(&group->mutex)=
;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0list_add_tail(&gdev->list=
, &group->devices);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mutex_unlock(&group->mute=
x);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0device_unlock(dev);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> =C2=A0}
> =C2=A0EXPORT_SYMBOL_GPL(iommu_group_add_device);
> @@ -1195,14 +1193,13 @@ void iommu_group_remove_device(struct device
> *dev)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct iommu_group *group=
;
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0device_lock(dev);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0device_lock_assert(dev);
> +
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0group =3D dev->iommu_grou=
p;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (group) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0dev_info(dev, "Removing from iommu group %d\n",
> group->id);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0__iommu_group_remove_device(dev);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0device_unlock(dev);
> -
> =C2=A0}
> =C2=A0EXPORT_SYMBOL_GPL(iommu_group_remove_device);
> =C2=A0

