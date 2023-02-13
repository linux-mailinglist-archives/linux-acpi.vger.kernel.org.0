Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA396950AD
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Feb 2023 20:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbjBMT2N (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 13 Feb 2023 14:28:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbjBMT2M (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 13 Feb 2023 14:28:12 -0500
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C139024;
        Mon, 13 Feb 2023 11:27:55 -0800 (PST)
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20230213192752usoutp025e4b2d2431e9f704baeb8c894179f58c~DePNMxY7F1527615276usoutp02U;
        Mon, 13 Feb 2023 19:27:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20230213192752usoutp025e4b2d2431e9f704baeb8c894179f58c~DePNMxY7F1527615276usoutp02U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1676316472;
        bh=NrItREScFuXNw3/cq5mvaAeNjjO2MiGw/sZ2JgF8Rwk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=IfmwcNrcSQqDiBVUFFrEXT8l+WQ/lf3EQWrZt24xGuwOyulhozfgWIResteCgFWeH
         SqmZUnoD+UTFdka/C2AmRp5ICBTpBJfStUDj1bpHytMAmL5+g3Ff1q2eTlETzPWYIs
         IXynMvsWD/4cS4bFp+WjLibt+lckW7ACkezQZufs=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
        [203.254.195.111]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230213192752uscas1p17900ccee8da551a4806d1d2b1c090887~DePNDBUJf0922609226uscas1p1C;
        Mon, 13 Feb 2023 19:27:52 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges2new.samsung.com (USCPEMTA) with SMTP id 7C.9E.49129.83F8AE36; Mon,
        13 Feb 2023 14:27:52 -0500 (EST)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
        [203.254.195.89]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230213192752uscas1p1c49508da4b100c9ba6a1a3aa92ca03e5~DePMvwylr0069200692uscas1p1e;
        Mon, 13 Feb 2023 19:27:52 +0000 (GMT)
X-AuditID: cbfec36f-167fe7000001bfe9-41-63ea8f38f15d
Received: from SSI-EX2.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id 8B.89.11378.73F8AE36; Mon,
        13 Feb 2023 14:27:52 -0500 (EST)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX2.ssi.samsung.com (105.128.2.227) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Mon, 13 Feb 2023 11:27:51 -0800
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
        SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Mon,
        13 Feb 2023 11:27:51 -0800
From:   Fan Ni <fan.ni@samsung.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "arnd@kernel.org" <arnd@kernel.org>
Subject: Re: [PATCH v2 13/20] cxl/region: Add region autodiscovery
Thread-Topic: [PATCH v2 13/20] cxl/region: Add region autodiscovery
Thread-Index: AQHZPS8BwEUv6lxvFESNil6PPdG9Oq7Nzj+A
Date:   Mon, 13 Feb 2023 19:27:51 +0000
Message-ID: <20230213192631.GA984720@bgt-140510-bm03>
In-Reply-To: <167601999958.1924368.9366954455835735048.stgit@dwillia2-xfh.jf.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <037F73170130C541B884F04C1E9FD389@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA02SeUiTcRjH+b3H9rpavM1qT+sAp52m1ShYh6LZsUKipKgt0tZ6UUs325x2
        QQWKZQ1NNHONnAd5sLSWR+o6tLLUwC4tJJIOp6Zpmp2uVvNV2H+f7/f5PjxffvwoXFBKiqho
        dTyjVStjxBweUdX4rdVPmvZJtaynUCitqrCS0uysp0jacz0FSYvupCFpq7GZkL61OElpR3oj
        FsSVFdh6MZm19CxHZh3O4MquNG2XfbXO3UYqeGsPMDHRCYx2aeA+XtRg8XMU974NHXk6mo1O
        oaQSlIooCugV0HrhYCriUQK6BEG2I59kRTIGtns27kRo5MZO1r+G4EllI8GKYQQttSYuK64i
        +PW+HEtFHhSH9oI7qdUcF0+jfeGCqR53hXC6AYPHJXW4a+BJr4O0+ns4GwqBmi8PSJYlYHdY
        x/oR9Dxorzrhsvn0SigbfMl1sQe9CyoNtYSLET0DfjRbxu7itBA6PuaOMdBTIf+yDWd5Bvyt
        fcdh2Qs6f/Ry2fwSMNcNc1gOhKrcu+PsC1fz+nD27lRoyvlIsLszob749Ti/pqDcEMzyesj9
        NkCyPAvaXmXh7MupoHSIx9oxkFtYMb66BvIc5Vg68jG6tTa6NTK6NTK6NTK6NTIjshQJ9Tpd
        bCSjk6iZRH+dMlanV0f6qzSxVvT/O7X8va+5hV51DPk3IIxCDQgoXDyN79nVoxLwDyiPHmO0
        mgitPobRNaBZFCEW8pcHNKkEdKQynjnEMHGMdmKKUR6iU5iFOCnLNqnkJYkt5knnt4d9GLLP
        nk8ueLijeMOikO/OBMuL7ttReHhntyGw/8XejvlBFbeKXgq9FfLqgD8XAzbHry/QKP7YnRvU
        TbyD6tUp++yjZQOP0uVYs97U6bWVOL1lxLqkvTLTFkrq7eLA3VpaXqmVDe72OK7ox7p2GSn5
        gCZjj5PvO9LmvUpUmLNwf82ZvrK6jK9hQfmOcIU18+aN0DkrJd3CiHPPjvpt9JSpMw+HyZvF
        l34ajOb+Kcmik9GEOKndYKrxqeie/PBN4oKNa353/VzkaSoypSRtyficIHH2Bod+Hm0s2POm
        b7rIohc4JGnEpi97j/dWx/mZaTGhi1IuX4xrdcp/iPCelL0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRmVeSWpSXmKPExsWS2cA0Sdei/1WywYolLBbbtmxitZg+9QKj
        xYsN7YwWy/f1M1qcn3WKxeLemv+sFrcmHGNyYPdYvOclk8emVZ1sHps+TWL3mHcy0OPzJrkA
        1igum5TUnMyy1CJ9uwSujPcrLjEWPLrKWHHh93TGBsaWlYxdjBwcEgImEl82hnYxcnEICaxm
        lJi07xoThPOJUeLh9YvMEM4yRomWrqtADicHm4CixL6u7WwgtoiAtsTEOQfBipgFDjFJnFi5
        G6xIWMBJov/gAWaIImeJnR+OsELYRhLP/mwCW80ioCpxbVsNSJhXwFRi3fsr7BDLljBKLL36
        jB0kwSkQLrG1dxcLiM0oICbx/dQaJhCbWUBc4taT+WC2hICAxJI955khbFGJl4//sULYihL3
        v79kh6jXkViw+xMbhG0nsW3+fihbW2LZwtfMEEcISpyc+YQFoldS4uCKGywTGCVmIVk3C8mo
        WUhGzUIyahaSUQsYWVcxipcWF+emVxQb5qWW6xUn5haX5qXrJefnbmIExvfpf4cjdzAevfVR
        7xAjEwfjIUYJDmYlEV7hpy+ShXhTEiurUovy44tKc1KLDzFKc7AoifMKuU6MFxJITyxJzU5N
        LUgtgskycXBKNTAFlfm90LJj/rdwzlozA8dA/p47C06uN3hooJr3jnfn5BB5nlM1MRkq+10t
        5l2MEV+zdcbypgfxaiUR2ZGyn2UXuibHXLknrDU76PIW75W33C7Oqa04ZdBoF7FmSdCPB1f4
        1RwSNPfPCVP65KWTZPh4/dJ1WgHRrpslqqWFX/bM648NvrzgcL90/oPemfsa49Nkwjl3HTvF
        VLa1Yq9n6ZsCQcYjyQFMXHKN9YIBb2qNHA7WtD0z33vc+/+NeWy9Dd2Lp0tId0e/UVA4MO2d
        oHTMRb7bkc6yn7dUu0XLP2rdPZ2Jj49/uv2V0FRtqdzQdxye/JyfIqr2Lzph1L20KWmr85O+
        r7KOWopsZut7lViKMxINtZiLihMB2mmJVV4DAAA=
X-CMS-MailID: 20230213192752uscas1p1c49508da4b100c9ba6a1a3aa92ca03e5
CMS-TYPE: 301P
X-CMS-RootMailID: 20230213192752uscas1p1c49508da4b100c9ba6a1a3aa92ca03e5
References: <167601992097.1924368.18291887895351917895.stgit@dwillia2-xfh.jf.intel.com>
        <167601999958.1924368.9366954455835735048.stgit@dwillia2-xfh.jf.intel.com>
        <CGME20230213192752uscas1p1c49508da4b100c9ba6a1a3aa92ca03e5@uscas1p1.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Feb 10, 2023 at 01:06:39AM -0800, Dan Williams wrote:
> Region autodiscovery is an asynchronous state machine advanced by
> cxl_port_probe(). After the decoders on an endpoint port are enumerated
> they are scanned for actively enabled instances. Each active decoder is
> flagged for auto-assembly CXL_DECODER_F_AUTO and attached to a region.
> If a region does not already exist for the address range setting of the
> decoder one is created. That creation process may race with other
> decoders of the same region being discovered since cxl_port_probe() is
> asynchronous. A new 'struct cxl_root_decoder' lock, @range_lock, is
> introduced to mitigate that race.
>=20
> Once all decoders have arrived, "p->nr_targets =3D=3D p->interleave_ways"=
,
> they are sorted by their relative decode position. The sort algorithm
> involves finding the point in the cxl_port topology where one leg of the
> decode leads to deviceA and the other deviceB. At that point in the
> topology the target order in the 'struct cxl_switch_decoder' indicates
> the relative position of those endpoint decoders in the region.
>=20
> >From that point the region goes through the same setup and validation
> steps as user-created regions, but instead of programming the decoders
> it validates that driver would have written the same values to the
> decoders as were already present.
>=20
> Tested-by: Fan Ni <fan.ni@samsung.com>
> Link: https://lore.kernel.org/r/167564540972.847146.17096178433176097831.=
stgit@dwillia2-xfh.jf.intel.com
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/core/hdm.c    |   11 +
>  drivers/cxl/core/port.c   |    2=20
>  drivers/cxl/core/region.c |  497 +++++++++++++++++++++++++++++++++++++++=
+++++-
>  drivers/cxl/cxl.h         |   29 +++
>  drivers/cxl/port.c        |   48 ++++
>  5 files changed, 576 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index a0891c3464f1..8c29026a4b9d 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -676,6 +676,14 @@ static int cxl_decoder_reset(struct cxl_decoder *cxl=
d)
>  	port->commit_end--;
>  	cxld->flags &=3D ~CXL_DECODER_F_ENABLE;
> =20
> +	/* Userspace is now responsible for reconfiguring this decoder */
> +	if (is_endpoint_decoder(&cxld->dev)) {
> +		struct cxl_endpoint_decoder *cxled;
> +
> +		cxled =3D to_cxl_endpoint_decoder(&cxld->dev);
> +		cxled->state =3D CXL_DECODER_STATE_MANUAL;
> +	}
> +
>  	return 0;
>  }
> =20
> @@ -783,6 +791,9 @@ static int init_hdm_decoder(struct cxl_port *port, st=
ruct cxl_decoder *cxld,
>  		return rc;
>  	}
>  	*dpa_base +=3D dpa_size + skip;
> +
> +	cxled->state =3D CXL_DECODER_STATE_AUTO;
> +
>  	return 0;
>  }
> =20
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 9e5df64ea6b5..59620528571a 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -446,6 +446,7 @@ bool is_endpoint_decoder(struct device *dev)
>  {
>  	return dev->type =3D=3D &cxl_decoder_endpoint_type;
>  }
> +EXPORT_SYMBOL_NS_GPL(is_endpoint_decoder, CXL);
> =20
>  bool is_root_decoder(struct device *dev)
>  {
> @@ -1628,6 +1629,7 @@ struct cxl_root_decoder *cxl_root_decoder_alloc(str=
uct cxl_port *port,
>  	}
> =20
>  	cxlrd->calc_hb =3D calc_hb;
> +	mutex_init(&cxlrd->range_lock);
> =20
>  	cxld =3D &cxlsd->cxld;
>  	cxld->dev.type =3D &cxl_decoder_root_type;
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 691605f1e120..3f6453da2c51 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -6,6 +6,7 @@
>  #include <linux/module.h>
>  #include <linux/slab.h>
>  #include <linux/uuid.h>
> +#include <linux/sort.h>
>  #include <linux/idr.h>
>  #include <cxlmem.h>
>  #include <cxl.h>
> @@ -524,7 +525,12 @@ static void cxl_region_iomem_release(struct cxl_regi=
on *cxlr)
>  	if (device_is_registered(&cxlr->dev))
>  		lockdep_assert_held_write(&cxl_region_rwsem);
>  	if (p->res) {
> -		remove_resource(p->res);
> +		/*
> +		 * Autodiscovered regions may not have been able to insert their
> +		 * resource.
> +		 */
> +		if (p->res->parent)
> +			remove_resource(p->res);
>  		kfree(p->res);
>  		p->res =3D NULL;
>  	}
> @@ -1105,12 +1111,35 @@ static int cxl_port_setup_targets(struct cxl_port=
 *port,
>  		return rc;
>  	}
> =20
> -	cxld->interleave_ways =3D iw;
> -	cxld->interleave_granularity =3D ig;
> -	cxld->hpa_range =3D (struct range) {
> -		.start =3D p->res->start,
> -		.end =3D p->res->end,
> -	};
> +	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
> +		if (cxld->interleave_ways !=3D iw ||
> +		    cxld->interleave_granularity !=3D ig ||
> +		    cxld->hpa_range.start !=3D p->res->start ||
> +		    cxld->hpa_range.end !=3D p->res->end ||
> +		    ((cxld->flags & CXL_DECODER_F_ENABLE) =3D=3D 0)) {
> +			dev_err(&cxlr->dev,
> +				"%s:%s %s expected iw: %d ig: %d %pr\n",
> +				dev_name(port->uport), dev_name(&port->dev),
> +				__func__, iw, ig, p->res);
> +			dev_err(&cxlr->dev,
> +				"%s:%s %s got iw: %d ig: %d state: %s %#llx:%#llx\n",
> +				dev_name(port->uport), dev_name(&port->dev),
> +				__func__, cxld->interleave_ways,
> +				cxld->interleave_granularity,
> +				(cxld->flags & CXL_DECODER_F_ENABLE) ?
> +					"enabled" :
> +					"disabled",
> +				cxld->hpa_range.start, cxld->hpa_range.end);
> +			return -ENXIO;
> +		}
> +	} else {
> +		cxld->interleave_ways =3D iw;
> +		cxld->interleave_granularity =3D ig;
> +		cxld->hpa_range =3D (struct range) {
> +			.start =3D p->res->start,
> +			.end =3D p->res->end,
> +		};
> +	}
>  	dev_dbg(&cxlr->dev, "%s:%s iw: %d ig: %d\n", dev_name(port->uport),
>  		dev_name(&port->dev), iw, ig);
>  add_target:
> @@ -1121,7 +1150,17 @@ static int cxl_port_setup_targets(struct cxl_port =
*port,
>  			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev), pos);
>  		return -ENXIO;
>  	}
> -	cxlsd->target[cxl_rr->nr_targets_set] =3D ep->dport;
> +	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
> +		if (cxlsd->target[cxl_rr->nr_targets_set] !=3D ep->dport) {
> +			dev_dbg(&cxlr->dev, "%s:%s: %s expected %s at %d\n",
> +				dev_name(port->uport), dev_name(&port->dev),
> +				dev_name(&cxlsd->cxld.dev),
> +				dev_name(ep->dport->dport),
> +				cxl_rr->nr_targets_set);
> +			return -ENXIO;
> +		}
> +	} else
> +		cxlsd->target[cxl_rr->nr_targets_set] =3D ep->dport;
>  	inc =3D 1;
>  out_target_set:
>  	cxl_rr->nr_targets_set +=3D inc;
> @@ -1163,6 +1202,13 @@ static void cxl_region_teardown_targets(struct cxl=
_region *cxlr)
>  	struct cxl_ep *ep;
>  	int i;
> =20
> +	/*
> +	 * In the auto-discovery case skip automatic teardown since the
> +	 * address space is already active
> +	 */
> +	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags))
> +		return;
> +
>  	for (i =3D 0; i < p->nr_targets; i++) {
>  		cxled =3D p->targets[i];
>  		cxlmd =3D cxled_to_memdev(cxled);
> @@ -1195,8 +1241,8 @@ static int cxl_region_setup_targets(struct cxl_regi=
on *cxlr)
>  			iter =3D to_cxl_port(iter->dev.parent);
> =20
>  		/*
> -		 * Descend the topology tree programming targets while
> -		 * looking for conflicts.
> +		 * Descend the topology tree programming / validating
> +		 * targets while looking for conflicts.
>  		 */
>  		for (ep =3D cxl_ep_load(iter, cxlmd); iter;
>  		     iter =3D ep->next, ep =3D cxl_ep_load(iter, cxlmd)) {
> @@ -1291,6 +1337,185 @@ static int cxl_region_attach_position(struct cxl_=
region *cxlr,
>  	return rc;
>  }
> =20
> +static int cxl_region_attach_auto(struct cxl_region *cxlr,
> +				  struct cxl_endpoint_decoder *cxled, int pos)
> +{
> +	struct cxl_region_params *p =3D &cxlr->params;
> +
> +	if (cxled->state !=3D CXL_DECODER_STATE_AUTO) {
> +		dev_err(&cxlr->dev,
> +			"%s: unable to add decoder to autodetected region\n",
> +			dev_name(&cxled->cxld.dev));
> +		return -EINVAL;
> +	}
> +
> +	if (pos >=3D 0) {
> +		dev_dbg(&cxlr->dev, "%s: expected auto position, not %d\n",
> +			dev_name(&cxled->cxld.dev), pos);
> +		return -EINVAL;
> +	}
> +
> +	if (p->nr_targets >=3D p->interleave_ways) {
> +		dev_err(&cxlr->dev, "%s: no more target slots available\n",
> +			dev_name(&cxled->cxld.dev));
> +		return -ENXIO;
> +	}
> +
> +	/*
> +	 * Temporarily record the endpoint decoder into the target array. Yes,
> +	 * this means that userspace can view devices in the wrong position
> +	 * before the region activates, and must be careful to understand when
> +	 * it might be racing region autodiscovery.
> +	 */
> +	pos =3D p->nr_targets;
> +	p->targets[pos] =3D cxled;
> +	cxled->pos =3D pos;
> +	p->nr_targets++;
> +
> +	return 0;
> +}
> +
> +static struct cxl_port *next_port(struct cxl_port *port)
> +{
> +	if (!port->parent_dport)
> +		return NULL;
> +	return port->parent_dport->port;
> +}
> +
> +static int decoder_match_range(struct device *dev, void *data)
> +{
> +	struct cxl_endpoint_decoder *cxled =3D data;
> +	struct cxl_switch_decoder *cxlsd;
> +
> +	if (!is_switch_decoder(dev))
> +		return 0;
> +
> +	cxlsd =3D to_cxl_switch_decoder(dev);
> +	return range_contains(&cxlsd->cxld.hpa_range, &cxled->cxld.hpa_range);
> +}
> +
> +static void find_positions(const struct cxl_switch_decoder *cxlsd,
> +			   const struct cxl_port *iter_a,
> +			   const struct cxl_port *iter_b, int *a_pos,
> +			   int *b_pos)
> +{
> +	int i;
> +
> +	for (i =3D 0, *a_pos =3D -1, *b_pos =3D -1; i < cxlsd->nr_targets; i++)=
 {
> +		if (cxlsd->target[i] =3D=3D iter_a->parent_dport)
> +			*a_pos =3D i;
> +		else if (cxlsd->target[i] =3D=3D iter_b->parent_dport)
> +			*b_pos =3D i;
> +		if (*a_pos >=3D 0 && *b_pos >=3D 0)
> +			break;
> +	}
> +}
> +
> +static int cmp_decode_pos(const void *a, const void *b)
> +{
> +	struct cxl_endpoint_decoder *cxled_a =3D *(typeof(cxled_a) *)a;
> +	struct cxl_endpoint_decoder *cxled_b =3D *(typeof(cxled_b) *)b;
> +	struct cxl_memdev *cxlmd_a =3D cxled_to_memdev(cxled_a);
> +	struct cxl_memdev *cxlmd_b =3D cxled_to_memdev(cxled_b);
> +	struct cxl_port *port_a =3D cxled_to_port(cxled_a);
> +	struct cxl_port *port_b =3D cxled_to_port(cxled_b);
> +	struct cxl_port *iter_a, *iter_b, *port =3D NULL;
> +	struct cxl_switch_decoder *cxlsd;
> +	struct device *dev;
> +	int a_pos, b_pos;
> +	unsigned int seq;
> +
> +	/* Exit early if any prior sorting failed */
> +	if (cxled_a->pos < 0 || cxled_b->pos < 0)
> +		return 0;
> +
> +	/*
> +	 * Walk up the hierarchy to find a shared port, find the decoder that
> +	 * maps the range, compare the relative position of those dport
> +	 * mappings.
> +	 */
> +	for (iter_a =3D port_a; iter_a; iter_a =3D next_port(iter_a)) {
> +		struct cxl_port *next_a, *next_b;
> +
> +		next_a =3D next_port(iter_a);
> +		if (!next_a)
> +			break;
> +
> +		for (iter_b =3D port_b; iter_b; iter_b =3D next_port(iter_b)) {
> +			next_b =3D next_port(iter_b);
> +			if (next_a !=3D next_b)
> +				continue;
> +			port =3D next_a;
> +			break;
> +		}
> +
> +		if (port)
> +			break;
> +	}
> +
> +	if (!port) {
> +		dev_err(cxlmd_a->dev.parent,
> +			"failed to find shared port with %s\n",
> +			dev_name(cxlmd_b->dev.parent));
> +		goto err;
> +	}
> +
> +	dev =3D device_find_child(&port->dev, cxled_a, decoder_match_range);
> +	if (!dev) {
> +		struct range *range =3D &cxled_a->cxld.hpa_range;
> +
> +		dev_err(port->uport,
> +			"failed to find decoder that maps %#llx-%#llx\n",
> +			range->start, range->end);
> +		goto err;
> +	}
> +
> +	cxlsd =3D to_cxl_switch_decoder(dev);
> +	do {
> +		seq =3D read_seqbegin(&cxlsd->target_lock);
> +		find_positions(cxlsd, iter_a, iter_b, &a_pos, &b_pos);
> +	} while (read_seqretry(&cxlsd->target_lock, seq));
> +
> +	put_device(dev);
> +
> +	if (a_pos < 0 || b_pos < 0) {
> +		dev_err(port->uport,
> +			"failed to find shared decoder for %s and %s\n",
> +			dev_name(cxlmd_a->dev.parent),
> +			dev_name(cxlmd_b->dev.parent));
> +		goto err;
> +	}
> +
> +	dev_dbg(port->uport, "%s comes %s %s\n", dev_name(cxlmd_a->dev.parent),
> +		a_pos - b_pos < 0 ? "before" : "after",
> +		dev_name(cxlmd_b->dev.parent));
> +
> +	return a_pos - b_pos;
> +err:
> +	cxled_a->pos =3D -1;
> +	return 0;
> +}
> +
> +static int cxl_region_sort_targets(struct cxl_region *cxlr)
> +{
> +	struct cxl_region_params *p =3D &cxlr->params;
> +	int i, rc =3D 0;
> +
> +	sort(p->targets, p->nr_targets, sizeof(p->targets[0]), cmp_decode_pos,
> +	     NULL);
> +
> +	for (i =3D 0; i < p->nr_targets; i++) {
> +		struct cxl_endpoint_decoder *cxled =3D p->targets[i];
> +
> +		if (cxled->pos < 0)
> +			rc =3D -ENXIO;
> +		cxled->pos =3D i;
> +	}
> +
> +	dev_dbg(&cxlr->dev, "region sort %s\n", rc ? "failed" : "successful");
> +	return rc;
> +}
> +
>  static int cxl_region_attach(struct cxl_region *cxlr,
>  			     struct cxl_endpoint_decoder *cxled, int pos)
>  {
> @@ -1354,6 +1579,50 @@ static int cxl_region_attach(struct cxl_region *cx=
lr,
>  		return -EINVAL;
>  	}
> =20
> +	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
> +		int i;
> +
> +		rc =3D cxl_region_attach_auto(cxlr, cxled, pos);
> +		if (rc)
> +			return rc;
> +
> +		/* await more targets to arrive... */
> +		if (p->nr_targets < p->interleave_ways)
> +			return 0;
> +
> +		/*
> +		 * All targets are here, which implies all PCI enumeration that
> +		 * affects this region has been completed. Walk the topology to
> +		 * sort the devices into their relative region decode position.
> +		 */
> +		rc =3D cxl_region_sort_targets(cxlr);
> +		if (rc)
> +			return rc;
> +
> +		for (i =3D 0; i < p->nr_targets; i++) {
> +			cxled =3D p->targets[i];
> +			ep_port =3D cxled_to_port(cxled);
> +			dport =3D cxl_find_dport_by_dev(root_port,
> +						      ep_port->host_bridge);
> +			rc =3D cxl_region_attach_position(cxlr, cxlrd, cxled,
> +							dport, i);
> +			if (rc)
> +				return rc;
> +		}
> +
> +		rc =3D cxl_region_setup_targets(cxlr);
> +		if (rc)
> +			return rc;
> +
> +		/*
> +		 * If target setup succeeds in the autodiscovery case
> +		 * then the region is already committed.
> +		 */
> +		p->state =3D CXL_CONFIG_COMMIT;
> +
> +		return 0;
> +	}
> +
>  	rc =3D cxl_region_validate_position(cxlr, cxled, pos);
>  	if (rc)
>  		return rc;
> @@ -2087,6 +2356,193 @@ static int devm_cxl_add_pmem_region(struct cxl_re=
gion *cxlr)
>  	return rc;
>  }
> =20
> +static int match_decoder_by_range(struct device *dev, void *data)
> +{
> +	struct range *r1, *r2 =3D data;
> +	struct cxl_root_decoder *cxlrd;
> +
> +	if (!is_root_decoder(dev))
> +		return 0;
> +
> +	cxlrd =3D to_cxl_root_decoder(dev);
> +	r1 =3D &cxlrd->cxlsd.cxld.hpa_range;
> +	return range_contains(r1, r2);
> +}
> +
> +static int match_region_by_range(struct device *dev, void *data)
> +{
> +	struct cxl_region_params *p;
> +	struct cxl_region *cxlr;
> +	struct range *r =3D data;
> +	int rc =3D 0;
> +
> +	if (!is_cxl_region(dev))
> +		return 0;
> +
> +	cxlr =3D to_cxl_region(dev);
> +	p =3D &cxlr->params;
> +
> +	down_read(&cxl_region_rwsem);
> +	if (p->res && p->res->start =3D=3D r->start && p->res->end =3D=3D r->en=
d)
> +		rc =3D 1;
> +	up_read(&cxl_region_rwsem);
> +
> +	return rc;
> +}
> +
> +/* Establish an empty region covering the given HPA range */
> +static struct cxl_region *construct_region(struct cxl_root_decoder *cxlr=
d,
> +					   struct cxl_endpoint_decoder *cxled)
> +{
> +	struct cxl_memdev *cxlmd =3D cxled_to_memdev(cxled);
> +	struct cxl_port *port =3D cxlrd_to_port(cxlrd);
> +	struct range *hpa =3D &cxled->cxld.hpa_range;
> +	struct cxl_region_params *p;
> +	struct cxl_region *cxlr;
> +	struct resource *res;
> +	int rc;
> +
> +	do {
> +		cxlr =3D __create_region(cxlrd, cxled->mode,
> +				       atomic_read(&cxlrd->region_id));
> +	} while (IS_ERR(cxlr) && PTR_ERR(cxlr) =3D=3D -EBUSY);
> +
> +	if (IS_ERR(cxlr)) {
> +		dev_err(cxlmd->dev.parent,
> +			"%s:%s: %s failed assign region: %ld\n",
> +			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
> +			__func__, PTR_ERR(cxlr));
> +		return cxlr;
> +	}
> +
> +	down_write(&cxl_region_rwsem);
> +	p =3D &cxlr->params;
> +	if (p->state >=3D CXL_CONFIG_INTERLEAVE_ACTIVE) {
> +		dev_err(cxlmd->dev.parent,
> +			"%s:%s: %s autodiscovery interrupted\n",
> +			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
> +			__func__);
> +		rc =3D -EBUSY;
> +		goto err;
> +	}
> +
> +	set_bit(CXL_REGION_F_AUTO, &cxlr->flags);
> +
> +	res =3D kmalloc(sizeof(*res), GFP_KERNEL);
> +	if (!res) {
> +		rc =3D -ENOMEM;
> +		goto err;
> +	}
> +
> +	*res =3D DEFINE_RES_MEM_NAMED(hpa->start, range_len(hpa),
> +				    dev_name(&cxlr->dev));
> +	rc =3D insert_resource(cxlrd->res, res);
> +	if (rc) {
> +		/*
> +		 * Platform-firmware may not have split resources like "System
> +		 * RAM" on CXL window boundaries see cxl_region_iomem_release()
> +		 */
> +		dev_warn(cxlmd->dev.parent,
> +			 "%s:%s: %s %s cannot insert resource\n",
> +			 dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
> +			 __func__, dev_name(&cxlr->dev));
> +	}
> +
> +	p->res =3D res;
> +	p->interleave_ways =3D cxled->cxld.interleave_ways;
> +	p->interleave_granularity =3D cxled->cxld.interleave_granularity;
> +	p->state =3D CXL_CONFIG_INTERLEAVE_ACTIVE;
> +
> +	rc =3D sysfs_update_group(&cxlr->dev.kobj, get_cxl_region_target_group(=
));
> +	if (rc)
> +		goto err;
> +
> +	dev_dbg(cxlmd->dev.parent, "%s:%s: %s %s res: %pr iw: %d ig: %d\n",
> +		dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev), __func__,
> +		dev_name(&cxlr->dev), p->res, p->interleave_ways,
> +		p->interleave_granularity);
> +
> +	/* ...to match put_device() in cxl_add_to_region() */
> +	get_device(&cxlr->dev);
> +	up_write(&cxl_region_rwsem);
> +
> +	return cxlr;
> +
> +err:
> +	up_write(&cxl_region_rwsem);
> +	devm_release_action(port->uport, unregister_region, cxlr);
> +	return ERR_PTR(rc);
> +}
> +
> +int cxl_add_to_region(struct cxl_port *root, struct cxl_endpoint_decoder=
 *cxled)
> +{
> +	struct cxl_memdev *cxlmd =3D cxled_to_memdev(cxled);
> +	struct range *hpa =3D &cxled->cxld.hpa_range;
> +	struct cxl_decoder *cxld =3D &cxled->cxld;
> +	struct cxl_root_decoder *cxlrd;
> +	struct cxl_region_params *p;
> +	struct cxl_region *cxlr;
> +	bool attach =3D false;
> +	struct device *dev;
> +	int rc;
> +
> +	dev =3D device_find_child(&root->dev, &cxld->hpa_range,
> +				match_decoder_by_range);
> +	if (!dev) {
> +		dev_err(cxlmd->dev.parent,
> +			"%s:%s no CXL window for range %#llx:%#llx\n",
> +			dev_name(&cxlmd->dev), dev_name(&cxld->dev),
> +			cxld->hpa_range.start, cxld->hpa_range.end);
> +		return -ENXIO;
> +	}
> +
> +	cxlrd =3D to_cxl_root_decoder(dev);
> +
> +	/*
> +	 * Ensure that if multiple threads race to construct_region() for @hpa
> +	 * one does the construction and the others add to that.
> +	 */
> +	mutex_lock(&cxlrd->range_lock);
> +	dev =3D device_find_child(&cxlrd->cxlsd.cxld.dev, hpa,
> +				match_region_by_range);
> +	if (!dev)
> +		cxlr =3D construct_region(cxlrd, cxled);
> +	else
> +		cxlr =3D to_cxl_region(dev);
> +	mutex_unlock(&cxlrd->range_lock);
> +
> +	if (IS_ERR(cxlr)) {
> +		rc =3D PTR_ERR(cxlr);
> +		goto out;
> +	}
> +
> +	attach_target(cxlr, cxled, -1, TASK_UNINTERRUPTIBLE);
> +
> +	down_read(&cxl_region_rwsem);
> +	p =3D &cxlr->params;
> +	attach =3D p->state =3D=3D CXL_CONFIG_COMMIT;
> +	up_read(&cxl_region_rwsem);
> +
> +	if (attach) {
> +		int rc =3D device_attach(&cxlr->dev);
> +
> +		/*
> +		 * If device_attach() fails the range may still be active via
> +		 * the platform-firmware memory map, otherwise the driver for
> +		 * regions is local to this file, so driver matching can't fail.
> +		 */
> +		if (rc < 0)
> +			dev_err(&cxlr->dev, "failed to enable, range: %pr\n",
> +				p->res);
> +	}
> +
> +	put_device(&cxlr->dev);
> +out:
> +	put_device(&cxlrd->cxlsd.cxld.dev);
> +	return rc;

rc can be returned without initialized as mentioned by Arnd Bergmann in
https://lore.kernel.org/linux-cxl/20230213101220.3821689-1-arnd@kernel.org/=
T/#u

> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_add_to_region, CXL);
> +
>  static int cxl_region_invalidate_memregion(struct cxl_region *cxlr)
>  {
>  	if (!test_bit(CXL_REGION_F_INCOHERENT, &cxlr->flags))
> @@ -2111,6 +2567,15 @@ static int cxl_region_invalidate_memregion(struct =
cxl_region *cxlr)
>  	return 0;
>  }
> =20
> +static int is_system_ram(struct resource *res, void *arg)
> +{
> +	struct cxl_region *cxlr =3D arg;
> +	struct cxl_region_params *p =3D &cxlr->params;
> +
> +	dev_dbg(&cxlr->dev, "%pr has System RAM: %pr\n", p->res, res);
> +	return 1;
> +}
> +
>  static int cxl_region_probe(struct device *dev)
>  {
>  	struct cxl_region *cxlr =3D to_cxl_region(dev);
> @@ -2144,6 +2609,18 @@ static int cxl_region_probe(struct device *dev)
>  	switch (cxlr->mode) {
>  	case CXL_DECODER_PMEM:
>  		return devm_cxl_add_pmem_region(cxlr);
> +	case CXL_DECODER_RAM:
> +		/*
> +		 * The region can not be manged by CXL if any portion of
> +		 * it is already online as 'System RAM'
> +		 */
> +		if (walk_iomem_res_desc(IORES_DESC_NONE,
> +					IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY,
> +					p->res->start, p->res->end, cxlr,
> +					is_system_ram) > 0)
> +			return 0;
> +		dev_dbg(dev, "TODO: hookup devdax\n");
> +		return 0;
>  	default:
>  		dev_dbg(&cxlr->dev, "unsupported region mode: %d\n",
>  			cxlr->mode);
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index ca76879af1de..c8ee4bb8cce6 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -261,6 +261,8 @@ resource_size_t cxl_rcrb_to_component(struct device *=
dev,
>   * cxl_decoder flags that define the type of memory / devices this
>   * decoder supports as well as configuration lock status See "CXL 2.0
>   * 8.2.5.12.7 CXL HDM Decoder 0 Control Register" for details.
> + * Additionally indicate whether decoder settings were autodetected,
> + * user customized.
>   */
>  #define CXL_DECODER_F_RAM   BIT(0)
>  #define CXL_DECODER_F_PMEM  BIT(1)
> @@ -334,12 +336,22 @@ static inline const char *cxl_decoder_mode_name(enu=
m cxl_decoder_mode mode)
>  	return "mixed";
>  }
> =20
> +/*
> + * Track whether this decoder is reserved for region autodiscovery, or
> + * free for userspace provisioning.
> + */
> +enum cxl_decoder_state {
> +	CXL_DECODER_STATE_MANUAL,
> +	CXL_DECODER_STATE_AUTO,
> +};
> +
>  /**
>   * struct cxl_endpoint_decoder - Endpoint  / SPA to DPA decoder
>   * @cxld: base cxl_decoder_object
>   * @dpa_res: actively claimed DPA span of this decoder
>   * @skip: offset into @dpa_res where @cxld.hpa_range maps
>   * @mode: which memory type / access-mode-partition this decoder targets
> + * @state: autodiscovery state
>   * @pos: interleave position in @cxld.region
>   */
>  struct cxl_endpoint_decoder {
> @@ -347,6 +359,7 @@ struct cxl_endpoint_decoder {
>  	struct resource *dpa_res;
>  	resource_size_t skip;
>  	enum cxl_decoder_mode mode;
> +	enum cxl_decoder_state state;
>  	int pos;
>  };
> =20
> @@ -380,6 +393,7 @@ typedef struct cxl_dport *(*cxl_calc_hb_fn)(struct cx=
l_root_decoder *cxlrd,
>   * @region_id: region id for next region provisioning event
>   * @calc_hb: which host bridge covers the n'th position by granularity
>   * @platform_data: platform specific configuration data
> + * @range_lock: sync region autodiscovery by address range
>   * @cxlsd: base cxl switch decoder
>   */
>  struct cxl_root_decoder {
> @@ -387,6 +401,7 @@ struct cxl_root_decoder {
>  	atomic_t region_id;
>  	cxl_calc_hb_fn calc_hb;
>  	void *platform_data;
> +	struct mutex range_lock;
>  	struct cxl_switch_decoder cxlsd;
>  };
> =20
> @@ -436,6 +451,13 @@ struct cxl_region_params {
>   */
>  #define CXL_REGION_F_INCOHERENT 0
> =20
> +/*
> + * Indicate whether this region has been assembled by autodetection or
> + * userspace assembly. Prevent endpoint decoders outside of automatic
> + * detection from being added to the region.
> + */
> +#define CXL_REGION_F_AUTO 1
> +
>  /**
>   * struct cxl_region - CXL region
>   * @dev: This region's device
> @@ -699,6 +721,8 @@ struct cxl_nvdimm_bridge *cxl_find_nvdimm_bridge(stru=
ct device *dev);
>  #ifdef CONFIG_CXL_REGION
>  bool is_cxl_pmem_region(struct device *dev);
>  struct cxl_pmem_region *to_cxl_pmem_region(struct device *dev);
> +int cxl_add_to_region(struct cxl_port *root,
> +		      struct cxl_endpoint_decoder *cxled);
>  #else
>  static inline bool is_cxl_pmem_region(struct device *dev)
>  {
> @@ -708,6 +732,11 @@ static inline struct cxl_pmem_region *to_cxl_pmem_re=
gion(struct device *dev)
>  {
>  	return NULL;
>  }
> +static inline int cxl_add_to_region(struct cxl_port *root,
> +				    struct cxl_endpoint_decoder *cxled)
> +{
> +	return 0;
> +}
>  #endif
> =20
>  /*
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index a8d46a67b45e..d88518836c2d 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -30,6 +30,34 @@ static void schedule_detach(void *cxlmd)
>  	schedule_cxl_memdev_detach(cxlmd);
>  }
> =20
> +static int discover_region(struct device *dev, void *root)
> +{
> +	struct cxl_endpoint_decoder *cxled;
> +	int rc;
> +
> +	if (!is_endpoint_decoder(dev))
> +		return 0;
> +
> +	cxled =3D to_cxl_endpoint_decoder(dev);
> +	if ((cxled->cxld.flags & CXL_DECODER_F_ENABLE) =3D=3D 0)
> +		return 0;
> +
> +	if (cxled->state !=3D CXL_DECODER_STATE_AUTO)
> +		return 0;
> +
> +	/*
> +	 * Region enumeration is opportunistic, if this add-event fails,
> +	 * continue to the next endpoint decoder.
> +	 */
> +	rc =3D cxl_add_to_region(root, cxled);
> +	if (rc)
> +		dev_dbg(dev, "failed to add to region: %#llx-%#llx\n",
> +			cxled->cxld.hpa_range.start, cxled->cxld.hpa_range.end);
> +
> +	return 0;
> +}
> +
> +
>  static int cxl_switch_port_probe(struct cxl_port *port)
>  {
>  	struct cxl_hdm *cxlhdm;
> @@ -54,6 +82,7 @@ static int cxl_endpoint_port_probe(struct cxl_port *por=
t)
>  	struct cxl_memdev *cxlmd =3D to_cxl_memdev(port->uport);
>  	struct cxl_dev_state *cxlds =3D cxlmd->cxlds;
>  	struct cxl_hdm *cxlhdm;
> +	struct cxl_port *root;
>  	int rc;
> =20
>  	cxlhdm =3D devm_cxl_setup_hdm(port);
> @@ -78,7 +107,24 @@ static int cxl_endpoint_port_probe(struct cxl_port *p=
ort)
>  		return rc;
>  	}
> =20
> -	return devm_cxl_enumerate_decoders(cxlhdm);
> +	rc =3D devm_cxl_enumerate_decoders(cxlhdm);
> +	if (rc)
> +		return rc;
> +
> +	/*
> +	 * This can't fail in practice as CXL root exit unregisters all
> +	 * descendant ports and that in turn synchronizes with cxl_port_probe()
> +	 */
> +	root =3D find_cxl_root(&cxlmd->dev);
> +
> +	/*
> +	 * Now that all endpoint decoders are successfully enumerated, try to
> +	 * assemble regions from committed decoders
> +	 */
> +	device_for_each_child(&port->dev, root, discover_region);
> +	put_device(&root->dev);
> +
> +	return 0;
>  }
> =20
>  static int cxl_port_probe(struct device *dev)
>=20
> =
