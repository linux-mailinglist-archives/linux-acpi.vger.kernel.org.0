Return-Path: <linux-acpi+bounces-3488-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 381148550DC
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Feb 2024 18:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B370A1F21487
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Feb 2024 17:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCDF985945;
	Wed, 14 Feb 2024 17:54:23 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5217864CCE;
	Wed, 14 Feb 2024 17:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707933263; cv=none; b=r8R5yVp+KPpmwpMm6kK0fu6a5AFuFgM2K0A0yVQqIMi6vOx8H6DHgH1OHol5ziC1nbmzfzAZWu5v2TgN+xoEDtH29ZcgMq1WmzUmhXFnpTZ2AgQ7+uqBIpvAOP7K2Qmm5ZNgjsfK3pyEwZGVblpk/MooRNiw13PxxUgqFEErbnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707933263; c=relaxed/simple;
	bh=ghwOtyRX3lifuXRWK5EKF/Nd4F95oq0MXCX4u7qpfKQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kAOtW+j92u+pK0c5juKtCX5a1xEzRdjKIQA+jNJTxk+IS8QqxgxBhUFZ1grLUx6w+J8RutC5lhS9vmsfvY/4Hk+b2Hk+gh3keNVREQ5nsHtcBIn5KhzrFFoIVMqbRkXiNPu5UdQWlFxkUigpde26kBQb/9znBKbs2ZALc1hrdYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TZm251kGGz67g0Y;
	Thu, 15 Feb 2024 01:50:37 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id E2178140D26;
	Thu, 15 Feb 2024 01:54:18 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 14 Feb
 2024 17:54:18 +0000
Date: Wed, 14 Feb 2024 17:54:17 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <wj28.lee@samsung.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"dave@stgolabs.net" <dave@stgolabs.net>, "brice.goglin@gmail.com"
	<brice.goglin@gmail.com>, "nifan.cxl@gmail.com" <nifan.cxl@gmail.com>,
	"rafael@kernel.org" <rafael@kernel.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, KyungSan Kim <ks0204.kim@samsung.com>, "Hojin
 Nam" <hj96.nam@samsung.com>
Subject: Re: [PATCH v4 08/11] cxl/region: Calculate performance data for a
 region
Message-ID: <20240214175417.00004910@Huawei.com>
In-Reply-To: <b243e80f-1b24-4756-8bb3-8389d66ea13a@intel.com>
References: <170568503239.1008395.2633682569497108646.stgit@djiang5-mobl3>
	<170568485801.1008395.12244787918793980621.stgit@djiang5-mobl3>
	<CGME20240119172408epcas2p2e461bf193d43347c70c18ad7681774a8@epcms2p4>
	<20240131022226epcms2p47d09167da93641ea88461563c494335a@epcms2p4>
	<b243e80f-1b24-4756-8bb3-8389d66ea13a@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 31 Jan 2024 08:56:41 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> On 1/30/24 19:22, Wonjae Lee wrote:
> > On Fri, Jan 19, 2024 at 10:23:52AM -0700, Dave Jiang wrote: =20
> >> Calculate and store the performance data for a CXL region. Find the wo=
rst
> >> read and write latency for all the included ranges from each of the de=
vices
> >> that attributes to the region and designate that as the latency data. =
Sum
> >> all the read and write bandwidth data for each of the device region and
> >> that is the total bandwidth for the region.
> >>
> >> The perf list is expected to be constructed before the endpoint decode=
rs
> >> are registered and thus there should be no early reading of the entries
> >> from the region assemble action. The calling of the region qos calcula=
te
> >> function is under the protection of cxl_dpa_rwsem and will ensure that
> >> all DPA associated work has completed.
> >>
> >> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> >> ---
> >> v4:
> >> - Calculate access classes 0 and 1 by retrieving host bridge coords
> >> - Add lockdep assert for cxl_dpa_rwsem (Dan)
> >> - Clarify that HMAT code is HMEM_REPORTING code. (Dan)
> >> ---
> >> =A0 drivers/cxl/core/cdat.c=A0 =A0 74 ++++++++++++++++++++++++++++++++=
+++++++++++++
> >> =A0 drivers/cxl/core/region.c =A0 =A0 2 +
> >> =A0 drivers/cxl/cxl.h=A0 =A0 =A0 =A0 =A0 =A0 4 ++
> >> =A0 3 files changed, 80 insertions(+)
> >>
> >> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> >> index 6e3998723aaa..7acb5837afad 100644
> >> --- a/drivers/cxl/core/cdat.c
> >> +++ b/drivers/cxl/core/cdat.c
> >> @@ -8,6 +8,7 @@
> >> =A0 #include "cxlpci.h"
> >> =A0 #include "cxlmem.h"
> >> =A0 #include "cxl.h"
> >> +#include "core.h"
> >>
> >> =A0 struct dsmas_entry {
> >> =A0 struct range dpa_range;
> >> @@ -546,3 +547,76 @@ void cxl_coordinates_combine(struct access_coordi=
nate *out,
> >> =A0 EXPORT_SYMBOL_NS_GPL(cxl_coordinates_combine, CXL);
> >>
> >> =A0 MODULE_IMPORT_NS(CXL);
> >> +
> >> +void cxl_region_perf_data_calculate(struct cxl_region *cxlr,
> >> +=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct cxl_endpoint_decoder *cxled)
> >> +{
> >> + struct cxl_memdev *cxlmd =3D cxled_to_memdev(cxled);
> >> + struct cxl_port *port =3D cxlmd->endpoint;
> >> + struct cxl_dev_state *cxlds =3D cxlmd->cxlds;
> >> + struct cxl_memdev_state *mds =3D to_cxl_memdev_state(cxlds);
> >> + struct access_coordinate hb_coord[ACCESS_COORDINATE_MAX];
> >> + struct access_coordinate coord;
> >> + struct range dpa =3D {
> >> +=A0 =A0 =A0 =A0 .start =3D cxled->dpa_res->start,
> >> +=A0 =A0 =A0 =A0 .end =3D cxled->dpa_res->end,
> >> + };
> >> + struct list_head *perf_list;
> >> + struct cxl_dpa_perf *perf;
> >> + bool found =3D false;
> >> + int rc;
> >> +
> >> + switch (cxlr->mode) {
> >> + case CXL_DECODER_RAM:
> >> +=A0 =A0 perf_list =3D &mds->ram_perf_list;
> >> +=A0 =A0 break;
> >> + case CXL_DECODER_PMEM:
> >> +=A0 =A0 perf_list =3D &mds->pmem_perf_list;
> >> +=A0 =A0 break;
> >> + default:
> >> +=A0 =A0 return;
> >> + }
> >> +
> >> + lockdep_assert_held(&cxl_dpa_rwsem);
> >> +
> >> + list_for_each_entry(perf, perf_list, list) {
> >> +=A0 =A0 if (range_contains(&perf->dpa_range, &dpa)) {
> >> +=A0 =A0 =A0 =A0 found =3D true;
> >> +=A0 =A0 =A0 =A0 break;
> >> +=A0 =A0 }
> >> + }
> >> +
> >> + if (!found)
> >> +=A0 =A0 return;
> >> +
> >> + rc =3D cxl_hb_get_perf_coordinates(port, hb_coord);
> >> + if (rc)=A0 {
> >> +=A0 =A0 dev_dbg(&port->dev, "Failed to retrieve hb perf coordinates.\=
n");
> >> +=A0 =A0 return;
> >> + }
> >> +
> >> + for (int i =3D 0; i < ACCESS_COORDINATE_MAX; i++) {
> >> +=A0 =A0 /* Pickup the host bridge coords */
> >> +=A0 =A0 cxl_coordinates_combine(&coord, &hb_coord[i], &perf->coord);
> >> +
> >> +=A0 =A0 /* Get total bandwidth and the worst latency for the cxl regi=
on */
> >> +=A0 =A0 cxlr->coord[i].read_latency =3D max_t(unsigned int,
> >> +=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cxlr->coord[i].read_l=
atency,
> >> +=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 coord.read_latency);
> >> +=A0 =A0 cxlr->coord[i].write_latency =3D max_t(unsigned int,
> >> +=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cxlr->coord[i].wr=
ite_latency,
> >> +=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 coord.write_laten=
cy);
> >> +=A0 =A0 cxlr->coord[i].read_bandwidth +=3D coord.read_bandwidth;
> >> +=A0 =A0 cxlr->coord[i].write_bandwidth +=3D coord.write_bandwidth;
> >> +
> >> +=A0 =A0 /*
> >> +=A0 =A0 =A0 * Convert latency to nanosec from picosec to be consistent
> >> +=A0 =A0 =A0 * with the resulting latency coordinates computed by the
> >> +=A0 =A0 =A0 * HMAT_REPORTING code.
> >> +=A0 =A0 =A0 */
> >> +=A0 =A0 cxlr->coord[i].read_latency =3D
> >> +=A0 =A0 =A0 =A0 DIV_ROUND_UP(cxlr->coord[i].read_latency, 1000);
> >> +=A0 =A0 cxlr->coord[i].write_latency =3D
> >> +=A0 =A0 =A0 =A0 DIV_ROUND_UP(cxlr->coord[i].write_latency, 1000); =20
> >=20
> > Hello,
> >=20
> > I ran into a bit of confusion and have a question while validating CDAT
> > behaviour with physical CXL devices. (I'm not sure if this is the right
> > thread to ask this question, sorry if it isn't.)
> >=20
> > IIUC, the raw data of latency is in picosec, but the comments on the
> > struct access_coordinate say that the latency units are in nanosec:
> >  * @read_latency:   Read latency in nanoseconds
> >  * @write_latency:  Write latency in nanoseconds
> >=20
> > This was a bit confusing at first, as the raw data of latency are in
> > ps, and the structure that stores the latency expects units of ns. =20
>=20
> Right. The numbers stored with the HMAT_REPORTING code and eventually NUM=
A nodes are normalized to nanoseconds, even though the raw data is in picos=
econds. For CXL, I left the CDAT and computed numbers as raw numbers (picos=
econds) until the final step when I calculate the latency for the entire re=
gion. And then it gets converted to nanoseconds in order to write back to t=
he memory_target for HMAT_REPORTING. The numbers we retrieve from HMAT_REPO=
RTING for the generic target is already in nanoseconds.

HMAT had a non backwards compatible change in units between the first
and second revs of that table. See ACPI 6.2 for revision 1.

With another hat on I'm a bit embarrassed about that :( .

>=20
>=20
> >=20
> > I saw that you have already had a discussion with Brice about the
> > pico/nanosecond unit conversion. My question is, are there any plans to
> > store latency number of cxl port in nanoseconds or change the comments
> > of coords structure? =20
>=20
> The numbers for the coords structure will remain in nanoseconds as it alw=
ays have been.=20
>=20
> >=20
> > Thanks,
> > Wonjae
> >  =20
> >> + }
> >> +}
> >> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> >> index 57a5901d5a60..7f19b533c5ae 100644
> >> --- a/drivers/cxl/core/region.c
> >> +++ b/drivers/cxl/core/region.c
> >> @@ -1722,6 +1722,8 @@ static int cxl_region_attach(struct cxl_region *=
cxlr,
> >> =A0 =A0 =A0 return -EINVAL;
> >> =A0 }
> >>
> >> + cxl_region_perf_data_calculate(cxlr, cxled);
> >> +
> >> =A0 if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
> >> =A0 =A0 =A0 int i;
> >>
> >> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> >> index 80e6bd294e18..f6637fa33113 100644
> >> --- a/drivers/cxl/cxl.h
> >> +++ b/drivers/cxl/cxl.h
> >> @@ -519,6 +519,7 @@ struct cxl_region_params {
> >> =A0 * @cxlr_pmem: (for pmem regions) cached copy of the nvdimm bridge
> >> =A0 * @flags: Region state flags
> >> =A0 * @params: active + config params for the region
> >> + * @coord: QoS access coordinates for the region
> >> =A0 */
> >> =A0 struct cxl_region {
> >> =A0 struct device dev;
> >> @@ -529,6 +530,7 @@ struct cxl_region {
> >> =A0 struct cxl_pmem_region *cxlr_pmem;
> >> =A0 unsigned long flags;
> >> =A0 struct cxl_region_params params;
> >> + struct access_coordinate coord[ACCESS_COORDINATE_MAX];
> >> =A0 };
> >>
> >> =A0 struct cxl_nvdimm_bridge {
> >> @@ -880,6 +882,8 @@ int cxl_endpoint_get_perf_coordinates(struct cxl_p=
ort *port,
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct access_coordinate *coor=
d);
> >> =A0 int cxl_hb_get_perf_coordinates(struct cxl_port *port,
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct access_coordinate *coord);
> >> +void cxl_region_perf_data_calculate(struct cxl_region *cxlr,
> >> +=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct cxl_endpoint_decoder *cxled);
> >>
> >> =A0 void cxl_coordinates_combine(struct access_coordinate *out,
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct access_coordinate *c1,
> >>
> >>
> >> =20
>=20


