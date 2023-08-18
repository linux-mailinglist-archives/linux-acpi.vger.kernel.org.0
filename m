Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A73A781283
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Aug 2023 20:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379293AbjHRSB3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 18 Aug 2023 14:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379356AbjHRSBB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Aug 2023 14:01:01 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9A03C0F
        for <linux-acpi@vger.kernel.org>; Fri, 18 Aug 2023 11:00:52 -0700 (PDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37IHr4pA006391;
        Fri, 18 Aug 2023 18:00:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=FjK6Qk297I6FQIeWHczgjk8DBvOjxzQVed81ZCIFzpM=;
 b=naMhw4zwg07FeJjJ0dX26LiCgpwVnBK1+6/SX+Y7uYprhffL5uCLCiiCNy50GE/pVRnj
 AVyyCcCMM26Qw8GhW7mDm6v2HdwCbv62h/WcdpjQA6+173zArbSNh0oaKlZ6RKO3Iy9Y
 1WrW1+SishQhSOP3NXlCbLfgz5Yqqo7TCCLqlNXYv1B74SPDYxby60oOWOWNFMQJIPG8
 1Ndaarcv/gGglXW8JDo8dnLbNJwNTcHmez2xm1k8wOBY2VeuQJ21RaGspz9ThWwzOFkB
 uR5K3iV/KwOqWeGdkVGNFOzJYxut4IyLbUkeULkzP3L/+xXvTv8Rp0TQ1a6/ZGnVA/qC iA== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sjdedg6ub-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Aug 2023 18:00:24 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37IH5eei018920;
        Fri, 18 Aug 2023 18:00:23 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3seq428ce7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Aug 2023 18:00:23 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
        by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37II0Mwf35062114
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Aug 2023 18:00:23 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BDA2858061;
        Fri, 18 Aug 2023 18:00:22 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C2A1458043;
        Fri, 18 Aug 2023 18:00:21 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown [9.61.79.45])
        by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 18 Aug 2023 18:00:21 +0000 (GMT)
Message-ID: <bff750f47b326c7c0066f1debc5411a8208a128c.camel@linux.ibm.com>
Subject: Re: [PATCH v2 0/4] Fix device_lock deadlock on two probe() paths
From:   Eric Farman <farman@linux.ibm.com>
To:     Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <jroedel@suse.de>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 18 Aug 2023 14:00:21 -0400
In-Reply-To: <ZN+XE7dk04f2C3D7@nvidia.com>
References: <CGME20230809144403eucas1p1345aec6ec34440f1794594426e0402ab@eucas1p1.samsung.com>
         <0-v2-d2762acaf50a+16d-iommu_group_locking2_jgg@nvidia.com>
         <d090f196-a5c2-b188-31bf-e42553d8d251@samsung.com>
         <ZN5n7GnlrTS6s5Yg@nvidia.com> <ZN-UpDFHab0vGuXp@suse.de>
         <ZN+XE7dk04f2C3D7@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Ppcchw2uaytaXBlr7S9gRwkfiNJ29soo
X-Proofpoint-GUID: Ppcchw2uaytaXBlr7S9gRwkfiNJ29soo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-18_22,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 priorityscore=1501 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0
 phishscore=0 adultscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308180162
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, 2023-08-18 at 13:06 -0300, Jason Gunthorpe wrote:
> On Fri, Aug 18, 2023 at 05:56:20PM +0200, Joerg Roedel wrote:
> > On Thu, Aug 17, 2023 at 03:33:16PM -0300, Jason Gunthorpe wrote:
> > > Bascially.. Yikes!
> >=20
> > Hmm, that is a difficult situation. Even if the problem is a misuse
> > of
> > the APIs we can not just blindly break other drivers by our core
> > changes.
>=20
> They are not broken, they just throw a lockdep warning and keep going
> as before. This is what triggers:
>=20
> static inline void device_lock_assert(struct device *dev)
> {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0lockdep_assert_held(&dev-=
>mutex);
> }
>=20
> So non-debug builds won't even see anything.
>=20
> > We need to resolve this situation pretty soon, otherwise I need to
> > remove the locking rework patches from the IOMMU tree until the
> > callers are fixed.
> >=20
> > Is there a way to keep the broken drivers working for now?
>=20
> Historically we've tolerated lockdep warnings as a way to motivate
> people who care to fix their stuff properly. eg the Intel VT-D had a
> lockdep warning at kernel boot for many releases before it was fixed.
>=20
> The series doesn't make things any functionally worse for these
> places
> misusing the API, but it now does throw a warning in some cases.

Hi Jason,

Well, I'm trying to chase down an apparent deadlock in the mdev cases
that is introduced with the commit [1] blamed by these fixes. Seems
that when iommu_group_{add|remove}_device gets called out of vfio (for
example, vfio-ap or -ccw), the device lock is already held so
attempting to get it again isn't going to go well.

As near as I see, mdev_device_create calls device_driver_attach, which
acquires the lock and eventually gets us into the vfio code, and then
vfio_device_set_group get us into the iommu side. Not sure how to best
untangle that.

I'm puzzled why lockdep isn't shouting over this for me, so I added a
lockdep_assert_not_held() in those paths to get a proper callchain:

[   49.319508] ------------[ cut here ]------------
[   49.319546] WARNING: CPU: 0 PID: 4472 at drivers/iommu/iommu.c:1216
iommu_group_add_device+0xfc/0x120
[   49.319562] Modules linked in: vhost_vsock
vmw_vsock_virtio_transport_common vsock vhost vhost_iotlb algif_hash
af_alg lcs ctcm fsm kvm xt_MASQUERADE xt_conntrack ipt_REJECT
nf_reject_ipv4 xt_tcpudp iptable_mangle iptable_nat nf_nat nf_conntrack
nf_defrag_ipv6 nf_defrag_ipv4 iptable_filter ip_tables x_tables bridge
stp llc vfio_ccw zcrypt_cex4 eadm_sch mdev vfio_iommu_type1 vfio loop
configfs zram zsmalloc ghash_s390 prng aes_s390 des_s390 libdes qeth_l2
sha512_s390 sha256_s390 sha1_s390 sha_common pkey zcrypt rng_core
dm_multipath dm_mod autofs4
[   49.319721] CPU: 0 PID: 4472 Comm: python Kdump: loaded Not tainted
6.5.0-rc6-next-20230818-dirty #2
[   49.319728] Hardware name: IBM 2964 NE1 749 (LPAR)
[   49.319734] Krnl PSW : 0704f00180000000 0000000190aab690
(iommu_group_add_device+0x100/0x120)
[   49.319748]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:3
PM:0 RI:0 EA:3
[   49.319758] Krnl GPRS: 0000000000000000 0000000100000000
0000000000000001 00000000ae8924f0
[   49.319765]            00000001bc05a920 000000008e7f8000
0000000000000000 0000000000000001
[   49.319772]            00000000ae892400 00000000ae892400
000000008d23b200 0000000000000000
[   49.319779]            000003ff901d8d18 000003ff90616a08
0000000190aab686 0000038005c8ba50
[   49.319792] Krnl Code: 0000000190aab680:
c0e5001e5624	brasl	%r14,0000000190e762c8
                          0000000190aab686:
ec26ff9f017e	cij	%r2,1,6,0000000190aab5c4
                         #0000000190aab68c:
af000000		mc	0,0
                         >0000000190aab690:
a7f4ff9a		brc	15,0000000190aab5c4
                          0000000190aab694:
b9040028		lgr	%r2,%r8
                          0000000190aab698:
c0e5001eb210	brasl	%r14,0000000190e81ab8
                          0000000190aab69e:
182b		lr	%r2,%r11
                          0000000190aab6a0:
eb6ff0a00004	lmg	%r6,%r15,160(%r15)
[   49.319872] Call Trace:
[   49.319878]  [<0000000190aab690>] iommu_group_add_device+0x100/0x120
[   49.319886] ([<0000000190aab686>] iommu_group_add_device+0xf6/0x120)
[   49.319894]  [<000003ff8002f404>] vfio_device_set_group+0x9c/0x128
[vfio]=20
[   49.319909]  [<000003ff8002cf12>]
vfio_register_emulated_iommu_dev+0x6a/0xd0 [vfio]=20
[   49.319918]  [<000003ff80083906>] vfio_ccw_mdev_probe+0xce/0x108
[vfio_ccw]=20
[   49.319931]  [<0000000190abdbc8>] really_probe+0xd0/0x338=20
[   49.319939]  [<0000000190abe3cc>] device_driver_attach+0x5c/0xc8=20
[   49.319947]  [<000003ff8003ca30>] mdev_device_create+0x200/0x278
[mdev]=20
[   49.319956]  [<000003ff8003ce1c>] create_store+0x8c/0xb8 [mdev]=20
[   49.319964]  [<000000019059fba2>] kernfs_fop_write_iter+0x142/0x1d8=20
[   49.319975]  [<00000001904c7c76>] vfs_write+0x1de/0x440=20
[   49.319986]  [<00000001904c814e>] ksys_write+0x6e/0x100=20
[   49.320024]  [<0000000190e75bfe>] __do_syscall+0x1de/0x208=20
[   49.320033]  [<0000000190e8c470>] system_call+0x70/0x98=20
[   49.320042] 5 locks held by python/4472:
[   49.320048]  #0: 0000000086d86440 (sb_writers#3){.+.+}-{0:0}, at:
ksys_write+0x6e/0x100
[   49.320074]  #1: 000000008d239c90 (&of->mutex){+.+.}-{3:3}, at:
kernfs_fop_write_iter+0x102/0x1d8
[   49.320095]  #2: 000000008ad95428 (kn->active#266){.+.+}-{0:0}, at:
kernfs_fop_write_iter+0x10e/0x1d8
[   49.320119]  #3: 00000000ae888b78 (&parent->unreg_sem){.+.+}-{3:3},
at: mdev_device_create+0x1b0/0x278 [mdev]
[   49.320141]  #4: 00000000ae8924f0 (&dev->mutex){....}-{3:3}, at:
device_driver_attach+0x4e/0xc8
[   49.320162] Last Breaking-Event-Address:
[   49.320168]  [<0000000190f7734c>] __s390_indirect_jump_r14+0x0/0xc
[   49.320179] irq event stamp: 147555
[   49.320185] hardirqs last  enabled at (147563): [<00000001901edcb4>]
console_unlock+0x10c/0x118
[   49.320194] hardirqs last disabled at (147570): [<00000001901edc96>]
console_unlock+0xee/0x118
[   49.320201] softirqs last  enabled at (147304): [<0000000190e8e674>]
__do_softirq+0x47c/0x510
[   49.320209] softirqs last disabled at (147295): [<000000019015732a>]
__irq_exit_rcu+0x11a/0x130
[   49.320218] ---[ end trace 0000000000000000 ]---

Thanks,
Eric

[1] a16b5d1681ab ("iommu: Complete the locking for dev->iommu_group")

>=20
> IMHO I'd rather keep the warning rather than supress it by adding
> device_locks(). Do you agree?
>=20
> Jason

