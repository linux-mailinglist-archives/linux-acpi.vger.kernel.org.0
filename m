Return-Path: <linux-acpi+bounces-3104-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E798433C8
	for <lists+linux-acpi@lfdr.de>; Wed, 31 Jan 2024 03:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE05628CFDA
	for <lists+linux-acpi@lfdr.de>; Wed, 31 Jan 2024 02:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430FB383A4;
	Wed, 31 Jan 2024 02:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="uDukt1+R"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E26938DE4
	for <linux-acpi@vger.kernel.org>; Wed, 31 Jan 2024 02:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706667753; cv=none; b=C9NAcvto+YZxtKIbG46dB16bFW+LX51TAnVeTmGHn0p9UV7iQW+zRNCW8uNb06OvpkuGmODydNUfR7dixzjVTkGWyR8fDv7XQTMyO+bA7QBvcdISa3gskpTcu7JBmrQLVvIKxtYMZQXF9WCfnSikOSynsFYveLx2zKUD9UHAn+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706667753; c=relaxed/simple;
	bh=WMMunzjFteyTbTLnQZ8xC8RHSMa58Sh5U1wSK7fafIo=;
	h=Mime-Version:Subject:From:To:CC:In-Reply-To:Message-ID:Date:
	 Content-Type:References; b=nz8tumFCdV3afGLKdskypOwuD/1j/vJKK1BkcJVsXBF1Kd07kd1u4iKqTTUKnF0i6JbPmXPMpejGOmY5+XqKg9P6/5VkpmlrrXskAWMSioWZseYliDsB2M4YZdIuWGVqfC1yAJ+gexupfl5rbOh8R/KGfBqpo2KcIJaDxNIeec8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=uDukt1+R; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240131022228epoutp01d65bfa8d6eac99269191bfb526e79798~vTUZjS1kV0718007180epoutp019
	for <linux-acpi@vger.kernel.org>; Wed, 31 Jan 2024 02:22:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240131022228epoutp01d65bfa8d6eac99269191bfb526e79798~vTUZjS1kV0718007180epoutp019
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1706667748;
	bh=WMMunzjFteyTbTLnQZ8xC8RHSMa58Sh5U1wSK7fafIo=;
	h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
	b=uDukt1+RFqXTei2cwWCJOFeQXCwUQ8WZ3KKajJQvJ1xiHc6yh6sc1nRliuQBlRFV0
	 z12/gOquiLQeQwS5TLtvqCVacs/z5CyyVlYKRjuWI0SAnc8l6kKaW7WkuFR+49z9wi
	 UySt9dWPze4pIX/ApJQBYcSpoUUz1lVHbfCapMck=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTP id
	20240131022227epcas2p4f0f830a7ac6fc0c814fe6a1395b7239f~vTUZDAbMg1629116291epcas2p4E;
	Wed, 31 Jan 2024 02:22:27 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.98]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4TPm5b0qTgz4x9Q8; Wed, 31 Jan
	2024 02:22:27 +0000 (GMT)
X-AuditID: b6c32a47-bfdfa70000002726-a0-65b9aee23119
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
	epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
	EA.CF.10022.2EEA9B56; Wed, 31 Jan 2024 11:22:26 +0900 (KST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: RE: [PATCH v4 08/11] cxl/region: Calculate performance data for a
 region
Reply-To: wj28.lee@samsung.com
Sender: Wonjae Lee <wj28.lee@samsung.com>
From: Wonjae Lee <wj28.lee@samsung.com>
To: Dave Jiang <dave.jiang@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>
CC: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>, "ira.weiny@intel.com"
	<ira.weiny@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, "dave@stgolabs.net" <dave@stgolabs.net>,
	"brice.goglin@gmail.com" <brice.goglin@gmail.com>, "nifan.cxl@gmail.com"
	<nifan.cxl@gmail.com>, "rafael@kernel.org" <rafael@kernel.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, KyungSan Kim
	<ks0204.kim@samsung.com>, Hojin Nam <hj96.nam@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <170568503239.1008395.2633682569497108646.stgit@djiang5-mobl3>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20240131022226epcms2p47d09167da93641ea88461563c494335a@epcms2p4>
Date: Wed, 31 Jan 2024 11:22:26 +0900
X-CMS-MailID: 20240131022226epcms2p47d09167da93641ea88461563c494335a
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHJsWRmVeSWpSXmKPExsWy7bCmue6jdTtTDX602FjcfXyBzaLzywVW
	i+lTLzBanLjZyGax+uYaRovmxevZLD68+cdisf/pcxaLVQuvsVkc3cNhsXxfP6PF+VmnWCz+
	btvLaDH3y1Rmi1sTjjE58HvsnHWX3aPlyFtWj8V7XjJ5bFrVyeaxf+4ado++LasYPabOrvf4
	vEkugCMq2yYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMH
	6HYlhbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFKToF5gV5xYm5xaV66Xl5qiZWhgYGR
	KVBhQnbGic4l7AVfAituff/N1MC43q+LkZNDQsBE4uL0ZUxdjFwcQgI7GCV+3rjD3MXIwcEr
	ICjxd4cwSI2wQLDE49ZWFhBbSEBO4u7tU0wQcU2JN9NWgcXZBNQlfnSeBJsjIjCXUeLTm3Xs
	IA6zwDkWiQOftjFBbOOVmNH+lAXClpbYvnwrI4jNKeAtMX3KFai4hsSPZb3MELaoxM3Vb9lh
	7PfH5jNC2CISrffOQtUISjz4uRsqLiXx9cRfsMUSAs2MEquP9bNCOA2MEh0zD0Nt0JdovP6e
	DcTmFfCVuL1/O9gGFgFViaaV3VCXukjcWvEOzGYW0JZYtvA1OFiYgX5ev0sfxJQQUJY4cosF
	ooJPouPwX3aYH3fMewI1RUliStsRqNskJBoat7JB2B4Sr+fOYZ3AqDgLEdazkOyahbBrASPz
	Kkax1ILi3PTUYqMCY3j0JufnbmIEJ2Qt9x2MM95+0DvEyMTBeIhRgoNZSYR3pdzOVCHelMTK
	qtSi/Pii0pzU4kOMpkBfTmSWEk3OB+aEvJJ4QxNLAxMzM0NzI1MDcyVx3nutc1OEBNITS1Kz
	U1MLUotg+pg4OKUamObK/zp8sd985YItx05rndYWc3oQbfnz8/xr39TvLPvwyuIsb85vnneF
	J3f8ar5zbW7L4VedYnObqvhFl6jf37+R9YzySeGpM9MfSZr/fFrsYH1UxPnXouPyZQE/Zx72
	q3iQusht65yC6udq17ez3rBfHOxYtGBlcTa3cerFsIXRwjsWbEoufKLaOWX95nTfx8V5Keyt
	3wSq9p6beVLjoKAY25dP1tsCv2oV3mLU2LWe3f/J+xjRZMbr8wUV4lq8Tx77v+xjBfeXoP7d
	K7Zf/FAsGOzvVWYyy6mvNcI1a3L9pdmMMR82pKRGb7d1DbgllHQ/vsRc1zvX1WatQupbFrk4
	qcdqprcrvhwNjNJy0lFiKc5INNRiLipOBABTf978UQQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240119172408epcas2p2e461bf193d43347c70c18ad7681774a8
References: <170568503239.1008395.2633682569497108646.stgit@djiang5-mobl3>
	<170568485801.1008395.12244787918793980621.stgit@djiang5-mobl3>
	<CGME20240119172408epcas2p2e461bf193d43347c70c18ad7681774a8@epcms2p4>

On Fri, Jan 19, 2024 at 10:23:52AM -0700, Dave Jiang wrote:
> Calculate and store the performance data for a CXL region. Find the worst
> read and write latency for all the included ranges from each of the devic=
es
> that attributes to the region and designate that as the latency data. Sum
> all the read and write bandwidth data for each of the device region and
> that is the total bandwidth for the region.
>
> The perf list is expected to be constructed before the endpoint decoders
> are registered and thus there should be no early reading of the entries
> from the region assemble action. The calling of the region qos calculate
> function is under the protection of cxl_dpa_rwsem and will ensure that
> all DPA associated work has completed.
>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron=40huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang=40intel.com>
> ---
> v4:
> - Calculate access classes 0 and 1 by retrieving host bridge coords
> - Add lockdep assert for cxl_dpa_rwsem (Dan)
> - Clarify that HMAT code is HMEM_REPORTING code. (Dan)
> ---
>=C2=A0=20drivers/cxl/core/cdat.c=C2=A0=20=C2=A0=2074=20+++++++++++++++++++=
++++++++++++++++++++++++++=0D=0A>=C2=A0=20drivers/cxl/core/region.c=20=C2=
=A0=20=C2=A0=202=20+=0D=0A>=C2=A0=20drivers/cxl/cxl.h=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=204=20++=0D=0A>=C2=A0=203=20files=20changed,=
=2080=20insertions(+)=0D=0A>=0D=0A>=20diff=20--git=20a/drivers/cxl/core/cda=
t.c=20b/drivers/cxl/core/cdat.c=0D=0A>=20index=206e3998723aaa..7acb5837afad=
=20100644=0D=0A>=20---=20a/drivers/cxl/core/cdat.c=0D=0A>=20+++=20b/drivers=
/cxl/core/cdat.c=0D=0A>=20=40=40=20-8,6=20+8,7=20=40=40=0D=0A>=C2=A0=20=23i=
nclude=20=22cxlpci.h=22=0D=0A>=C2=A0=20=23include=20=22cxlmem.h=22=0D=0A>=
=C2=A0=20=23include=20=22cxl.h=22=0D=0A>=20+=23include=20=22core.h=22=0D=0A=
>=0D=0A>=C2=A0=20struct=20dsmas_entry=20=7B=0D=0A>=C2=A0=20struct=20range=
=20dpa_range;=0D=0A>=20=40=40=20-546,3=20+547,76=20=40=40=20void=20cxl_coor=
dinates_combine(struct=20access_coordinate=20*out,=0D=0A>=C2=A0=20EXPORT_SY=
MBOL_NS_GPL(cxl_coordinates_combine,=20CXL);=0D=0A>=0D=0A>=C2=A0=20MODULE_I=
MPORT_NS(CXL);=0D=0A>=20+=0D=0A>=20+void=20cxl_region_perf_data_calculate(s=
truct=20cxl_region=20*cxlr,=0D=0A>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20struct=20cxl_endpoint_decoder=20*cxled)=
=0D=0A>=20+=7B=0D=0A>=20+=20struct=20cxl_memdev=20*cxlmd=20=3D=20cxled_to_m=
emdev(cxled);=0D=0A>=20+=20struct=20cxl_port=20*port=20=3D=20cxlmd->endpoin=
t;=0D=0A>=20+=20struct=20cxl_dev_state=20*cxlds=20=3D=20cxlmd->cxlds;=0D=0A=
>=20+=20struct=20cxl_memdev_state=20*mds=20=3D=20to_cxl_memdev_state(cxlds)=
;=0D=0A>=20+=20struct=20access_coordinate=20hb_coord=5BACCESS_COORDINATE_MA=
X=5D;=0D=0A>=20+=20struct=20access_coordinate=20coord;=0D=0A>=20+=20struct=
=20range=20dpa=20=3D=20=7B=0D=0A>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20.s=
tart=20=3D=20cxled->dpa_res->start,=0D=0A>=20+=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20.end=20=3D=20cxled->dpa_res->end,=0D=0A>=20+=20=7D;=0D=0A>=20+=20s=
truct=20list_head=20*perf_list;=0D=0A>=20+=20struct=20cxl_dpa_perf=20*perf;=
=0D=0A>=20+=20bool=20found=20=3D=20false;=0D=0A>=20+=20int=20rc;=0D=0A>=20+=
=0D=0A>=20+=20switch=20(cxlr->mode)=20=7B=0D=0A>=20+=20case=20CXL_DECODER_R=
AM:=0D=0A>=20+=C2=A0=20=C2=A0=20perf_list=20=3D=20&mds->ram_perf_list;=0D=
=0A>=20+=C2=A0=20=C2=A0=20break;=0D=0A>=20+=20case=20CXL_DECODER_PMEM:=0D=
=0A>=20+=C2=A0=20=C2=A0=20perf_list=20=3D=20&mds->pmem_perf_list;=0D=0A>=20=
+=C2=A0=20=C2=A0=20break;=0D=0A>=20+=20default:=0D=0A>=20+=C2=A0=20=C2=A0=
=20return;=0D=0A>=20+=20=7D=0D=0A>=20+=0D=0A>=20+=20lockdep_assert_held(&cx=
l_dpa_rwsem);=0D=0A>=20+=0D=0A>=20+=20list_for_each_entry(perf,=20perf_list=
,=20list)=20=7B=0D=0A>=20+=C2=A0=20=C2=A0=20if=20(range_contains(&perf->dpa=
_range,=20&dpa))=20=7B=0D=0A>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20found=
=20=3D=20true;=0D=0A>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20break;=0D=0A>=
=20+=C2=A0=20=C2=A0=20=7D=0D=0A>=20+=20=7D=0D=0A>=20+=0D=0A>=20+=20if=20(=
=21found)=0D=0A>=20+=C2=A0=20=C2=A0=20return;=0D=0A>=20+=0D=0A>=20+=20rc=20=
=3D=20cxl_hb_get_perf_coordinates(port,=20hb_coord);=0D=0A>=20+=20if=20(rc)=
=C2=A0=20=7B=0D=0A>=20+=C2=A0=20=C2=A0=20dev_dbg(&port->dev,=20=22Failed=20=
to=20retrieve=20hb=20perf=20coordinates.=5Cn=22);=0D=0A>=20+=C2=A0=20=C2=A0=
=20return;=0D=0A>=20+=20=7D=0D=0A>=20+=0D=0A>=20+=20for=20(int=20i=20=3D=20=
0;=20i=20<=20ACCESS_COORDINATE_MAX;=20i++)=20=7B=0D=0A>=20+=C2=A0=20=C2=A0=
=20/*=20Pickup=20the=20host=20bridge=20coords=20*/=0D=0A>=20+=C2=A0=20=C2=
=A0=20cxl_coordinates_combine(&coord,=20&hb_coord=5Bi=5D,=20&perf->coord);=
=0D=0A>=20+=0D=0A>=20+=C2=A0=20=C2=A0=20/*=20Get=20total=20bandwidth=20and=
=20the=20worst=20latency=20for=20the=20cxl=20region=20*/=0D=0A>=20+=C2=A0=
=20=C2=A0=20cxlr->coord=5Bi=5D.read_latency=20=3D=20max_t(unsigned=20int,=
=0D=0A>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20cxlr->coord=5Bi=5D.read_latenc=
y,=0D=0A>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20coord.read_latency);=0D=0A>=
=20+=C2=A0=20=C2=A0=20cxlr->coord=5Bi=5D.write_latency=20=3D=20max_t(unsign=
ed=20int,=0D=0A>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20cxlr->coord=
=5Bi=5D.write_latency,=0D=0A>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
coord.write_latency);=0D=0A>=20+=C2=A0=20=C2=A0=20cxlr->coord=5Bi=5D.read_b=
andwidth=20+=3D=20coord.read_bandwidth;=0D=0A>=20+=C2=A0=20=C2=A0=20cxlr->c=
oord=5Bi=5D.write_bandwidth=20+=3D=20coord.write_bandwidth;=0D=0A>=20+=0D=
=0A>=20+=C2=A0=20=C2=A0=20/*=0D=0A>=20+=C2=A0=20=C2=A0=20=C2=A0=20*=20Conve=
rt=20latency=20to=20nanosec=20from=20picosec=20to=20be=20consistent=0D=0A>=
=20+=C2=A0=20=C2=A0=20=C2=A0=20*=20with=20the=20resulting=20latency=20coord=
inates=20computed=20by=20the=0D=0A>=20+=C2=A0=20=C2=A0=20=C2=A0=20*=20HMAT_=
REPORTING=20code.=0D=0A>=20+=C2=A0=20=C2=A0=20=C2=A0=20*/=0D=0A>=20+=C2=A0=
=20=C2=A0=20cxlr->coord=5Bi=5D.read_latency=20=3D=0D=0A>=20+=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20DIV_ROUND_UP(cxlr->coord=5Bi=5D.read_latency,=201000);=
=0D=0A>=20+=C2=A0=20=C2=A0=20cxlr->coord=5Bi=5D.write_latency=20=3D=0D=0A>=
=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20DIV_ROUND_UP(cxlr->coord=5Bi=5D.wri=
te_latency,=201000);=0D=0A=0D=0AHello,=0D=0A=0D=0AI=20ran=20into=20a=20bit=
=20of=20confusion=20and=20have=20a=20question=20while=20validating=20CDAT=
=0D=0Abehaviour=20with=20physical=20CXL=20devices.=20(I'm=20not=20sure=20if=
=20this=20is=20the=20right=0D=0Athread=20to=20ask=20this=20question,=20sorr=
y=20if=20it=20isn't.)=0D=0A=0D=0AIIUC,=20the=20raw=20data=20of=20latency=20=
is=20in=20picosec,=20but=20the=20comments=20on=20the=0D=0Astruct=20access_c=
oordinate=20say=20that=20the=20latency=20units=20are=20in=20nanosec:=0D=0A=
=20*=20=40read_latency:=20=20=20Read=20latency=20in=20nanoseconds=0D=0A=20*=
=20=40write_latency:=20=20Write=20latency=20in=20nanoseconds=0D=0A=0D=0AThi=
s=20was=20a=20bit=20confusing=20at=20first,=20as=20the=20raw=20data=20of=20=
latency=20are=20in=0D=0Aps,=20and=20the=20structure=20that=20stores=20the=
=20latency=20expects=20units=20of=20ns.=0D=0A=0D=0AI=20saw=20that=20you=20h=
ave=20already=20had=20a=20discussion=20with=20Brice=20about=20the=0D=0Apico=
/nanosecond=20unit=20conversion.=20My=20question=20is,=20are=20there=20any=
=20plans=20to=0D=0Astore=20latency=20number=20of=20cxl=20port=20in=20nanose=
conds=20or=20change=20the=20comments=0D=0Aof=20coords=20structure?=0D=0A=0D=
=0AThanks,=0D=0AWonjae=0D=0A=0D=0A>=20+=20=7D=0D=0A>=20+=7D=0D=0A>=20diff=
=20--git=20a/drivers/cxl/core/region.c=20b/drivers/cxl/core/region.c=0D=0A>=
=20index=2057a5901d5a60..7f19b533c5ae=20100644=0D=0A>=20---=20a/drivers/cxl=
/core/region.c=0D=0A>=20+++=20b/drivers/cxl/core/region.c=0D=0A>=20=40=40=
=20-1722,6=20+1722,8=20=40=40=20static=20int=20cxl_region_attach(struct=20c=
xl_region=20*cxlr,=0D=0A>=C2=A0=20=C2=A0=20=C2=A0=20return=20-EINVAL;=0D=0A=
>=C2=A0=20=7D=0D=0A>=0D=0A>=20+=20cxl_region_perf_data_calculate(cxlr,=20cx=
led);=0D=0A>=20+=0D=0A>=C2=A0=20if=20(test_bit(CXL_REGION_F_AUTO,=20&cxlr->=
flags))=20=7B=0D=0A>=C2=A0=20=C2=A0=20=C2=A0=20int=20i;=0D=0A>=0D=0A>=20dif=
f=20--git=20a/drivers/cxl/cxl.h=20b/drivers/cxl/cxl.h=0D=0A>=20index=2080e6=
bd294e18..f6637fa33113=20100644=0D=0A>=20---=20a/drivers/cxl/cxl.h=0D=0A>=
=20+++=20b/drivers/cxl/cxl.h=0D=0A>=20=40=40=20-519,6=20+519,7=20=40=40=20s=
truct=20cxl_region_params=20=7B=0D=0A>=C2=A0=20*=20=40cxlr_pmem:=20(for=20p=
mem=20regions)=20cached=20copy=20of=20the=20nvdimm=20bridge=0D=0A>=C2=A0=20=
*=20=40flags:=20Region=20state=20flags=0D=0A>=C2=A0=20*=20=40params:=20acti=
ve=20+=20config=20params=20for=20the=20region=0D=0A>=20+=20*=20=40coord:=20=
QoS=20access=20coordinates=20for=20the=20region=0D=0A>=C2=A0=20*/=0D=0A>=C2=
=A0=20struct=20cxl_region=20=7B=0D=0A>=C2=A0=20struct=20device=20dev;=0D=0A=
>=20=40=40=20-529,6=20+530,7=20=40=40=20struct=20cxl_region=20=7B=0D=0A>=C2=
=A0=20struct=20cxl_pmem_region=20*cxlr_pmem;=0D=0A>=C2=A0=20unsigned=20long=
=20flags;=0D=0A>=C2=A0=20struct=20cxl_region_params=20params;=0D=0A>=20+=20=
struct=20access_coordinate=20coord=5BACCESS_COORDINATE_MAX=5D;=0D=0A>=C2=A0=
=20=7D;=0D=0A>=0D=0A>=C2=A0=20struct=20cxl_nvdimm_bridge=20=7B=0D=0A>=20=40=
=40=20-880,6=20+882,8=20=40=40=20int=20cxl_endpoint_get_perf_coordinates(st=
ruct=20cxl_port=20*port,=0D=0A>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20struct=20access_coordinate=
=20*coord);=0D=0A>=C2=A0=20int=20cxl_hb_get_perf_coordinates(struct=20cxl_p=
ort=20*port,=0D=0A>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20struct=20access_coordinate=20*coord);=0D=0A>=20+void=20cxl_region_=
perf_data_calculate(struct=20cxl_region=20*cxlr,=0D=0A>=20+=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20struct=20cxl_endpo=
int_decoder=20*cxled);=0D=0A>=0D=0A>=C2=A0=20void=20cxl_coordinates_combine=
(struct=20access_coordinate=20*out,=0D=0A>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20struct=20access_coordinate=20*c1,=0D=
=0A>=0D=0A>=0D=0A>

