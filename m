Return-Path: <linux-acpi+bounces-1993-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 056AE7FF22E
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 15:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF1E42844C0
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 14:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A135100D
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 14:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B236E84;
	Thu, 30 Nov 2023 05:23:14 -0800 (PST)
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-58d9a0ead0cso180404eaf.0;
        Thu, 30 Nov 2023 05:23:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701350594; x=1701955394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mJ4HfSjmHmp/z8LKb9u0O3izJUOjiP9hVgtxT/yNmWw=;
        b=VKuSingPxXB2+dkkjqfFRXv7xcan/iorLKkORvSk2ztDBnK7OX93HpqKkqboZuen0M
         CS7/Z3D3tZicHO3IAiTp+LT0GbUOsxbdVEcbYOnmOPJzz0Qs98AwlZ6f0hf+BN2Hc0hE
         C5tRn30amkYl33ng++wUiKr4qKoj46J2vDfelQ8OxKFgnE8iEOKkG5uGtC7DrzkQxV6I
         9FDrIePf0fzuUUZUOXCpM9UmqZ7aSb+GkPFVmWukSlct5VqFIMNGmywgRGd1NJlv0etp
         G2jUnvCX7T/1CRX8lh0reb0UK7aDZ3uPvO5ZMzpEqRt8bmTifsYWEBfi/dM6II42jUYb
         tswg==
X-Gm-Message-State: AOJu0YwEgC9sYGYneb6/XCLkpbVaFOXK7tW6PVa9vFmd54YgtgcExs9J
	yoagPdseVR3cKiURrxEF4LhgXzxNBjxREk/YaQM=
X-Google-Smtp-Source: AGHT+IHz57RxLZa4J1YxA2XttUwodX0GdXV5ylkhZb4Oyz6eVI2ERRPlDmHL2wK9GIJ4wc86qAKgBv8QpHj+lMuC3ss=
X-Received: by 2002:a4a:e702:0:b0:58d:e73a:eb79 with SMTP id
 y2-20020a4ae702000000b0058de73aeb79mr2180906oou.0.1701350593894; Thu, 30 Nov
 2023 05:23:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0-v1-f82a05539a64+5042-iommu_fwspec_p2_jgg@nvidia.com> <4-v1-f82a05539a64+5042-iommu_fwspec_p2_jgg@nvidia.com>
In-Reply-To: <4-v1-f82a05539a64+5042-iommu_fwspec_p2_jgg@nvidia.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 30 Nov 2023 14:23:02 +0100
Message-ID: <CAJZ5v0jZYy=hSn0hVV_dBw7rqY4NwcTn6ODo_-g_EVkzcnMBsQ@mail.gmail.com>
Subject: Re: [PATCH 04/30] ACPI: IORT: Remove fwspec from the reserved region code
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: acpica-devel@lists.linux.dev, Andy Gross <agross@kernel.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
	Bjorn Andersson <andersson@kernel.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, asahi@lists.linux.dev, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, devicetree@vger.kernel.org, 
	Frank Rowand <frowand.list@gmail.com>, Hanjun Guo <guohanjun@huawei.com>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Heiko Stuebner <heiko@sntech.de>, iommu@lists.linux.dev, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Joerg Roedel <joro@8bytes.org>, 
	Kees Cook <keescook@chromium.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Len Brown <lenb@kernel.org>, 
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev, 
	linux-tegra@vger.kernel.org, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Hector Martin <marcan@marcan.st>, 
	Matthias Brugger <matthias.bgg@gmail.com>, Orson Zhai <orsonzhai@gmail.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Rob Clark <robdclark@gmail.com>, 
	Robert Moore <robert.moore@intel.com>, Rob Herring <robh+dt@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Samuel Holland <samuel@sholland.org>, 
	Sudeep Holla <sudeep.holla@arm.com>, Sven Peter <sven@svenpeter.dev>, 
	Thierry Reding <thierry.reding@gmail.com>, Krishna Reddy <vdumpa@nvidia.com>, 
	virtualization@lists.linux.dev, Chen-Yu Tsai <wens@csie.org>, 
	Will Deacon <will@kernel.org>, Yong Wu <yong.wu@mediatek.com>, 
	Chunyan Zhang <zhang.lyra@gmail.com>, =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 2:10=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> iort_iommu_get_resv_regions() needs access to the parsed id array that is
> currently stored in the iommu_fwspec.
>
> Instead of getting this from the fwspec inside the iort code have the
> caller pass it in.
>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/acpi/arm64/iort.c | 88 ++++++++++++++++++++++++---------------
>  drivers/iommu/dma-iommu.c |  7 +++-
>  include/linux/acpi_iort.h |  8 +++-
>  3 files changed, 65 insertions(+), 38 deletions(-)
>
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index 5c9b4c23f96a87..93e30f2f5004f0 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -946,11 +946,19 @@ static u32 *iort_rmr_alloc_sids(u32 *sids, u32 coun=
t, u32 id_start,
>         return new_sids;
>  }
>
> -static bool iort_rmr_has_dev(struct device *dev, u32 id_start,
> +struct iort_resv_args {
> +       struct device *dev;
> +       struct list_head *head;
> +       struct fwnode_handle *iommu_fwnode;
> +       const u32 *fw_ids;
> +       unsigned int fw_num_ids;
> +};
> +
> +static bool iort_rmr_has_dev(struct iort_resv_args *args, u32 id_start,
>                              u32 id_count)
>  {
> +       struct device *dev =3D args->dev;
>         int i;
> -       struct iommu_fwspec *fwspec =3D dev_iommu_fwspec_get(dev);
>
>         /*
>          * Make sure the kernel has preserved the boot firmware PCIe
> @@ -965,18 +973,18 @@ static bool iort_rmr_has_dev(struct device *dev, u3=
2 id_start,
>                         return false;
>         }
>
> -       for (i =3D 0; i < fwspec->num_ids; i++) {
> -               if (fwspec->ids[i] >=3D id_start &&
> -                   fwspec->ids[i] <=3D id_start + id_count)
> +       for (i =3D 0; i < args->fw_num_ids; i++) {
> +               if (args->fw_ids[i] >=3D id_start &&
> +                   args->fw_ids[i] <=3D id_start + id_count)
>                         return true;
>         }
>
>         return false;
>  }
>
> -static void iort_node_get_rmr_info(struct acpi_iort_node *node,
> -                                  struct acpi_iort_node *iommu,
> -                                  struct device *dev, struct list_head *=
head)
> +static void iort_node_get_rmr_info(struct iort_resv_args *args,
> +                                  struct acpi_iort_node *node,
> +                                  struct acpi_iort_node *iommu)
>  {
>         struct acpi_iort_node *smmu =3D NULL;
>         struct acpi_iort_rmr *rmr;
> @@ -1013,8 +1021,8 @@ static void iort_node_get_rmr_info(struct acpi_iort=
_node *node,
>                         continue;
>
>                 /* If dev is valid, check RMR node corresponds to the dev=
 SID */
> -               if (dev && !iort_rmr_has_dev(dev, map->output_base,
> -                                            map->id_count))
> +               if (args->dev &&
> +                   !iort_rmr_has_dev(args, map->output_base, map->id_cou=
nt))
>                         continue;
>
>                 /* Retrieve SIDs associated with the Node. */
> @@ -1029,12 +1037,12 @@ static void iort_node_get_rmr_info(struct acpi_io=
rt_node *node,
>         if (!sids)
>                 return;
>
> -       iort_get_rmrs(node, smmu, sids, num_sids, head);
> +       iort_get_rmrs(node, smmu, sids, num_sids, args->head);
>         kfree(sids);
>  }
>
> -static void iort_find_rmrs(struct acpi_iort_node *iommu, struct device *=
dev,
> -                          struct list_head *head)
> +static void iort_find_rmrs(struct iort_resv_args *args,
> +                          struct acpi_iort_node *iommu)
>  {
>         struct acpi_table_iort *iort;
>         struct acpi_iort_node *iort_node, *iort_end;
> @@ -1057,7 +1065,7 @@ static void iort_find_rmrs(struct acpi_iort_node *i=
ommu, struct device *dev,
>                         return;
>
>                 if (iort_node->type =3D=3D ACPI_IORT_NODE_RMR)
> -                       iort_node_get_rmr_info(iort_node, iommu, dev, hea=
d);
> +                       iort_node_get_rmr_info(args, iort_node, iommu);
>
>                 iort_node =3D ACPI_ADD_PTR(struct acpi_iort_node, iort_no=
de,
>                                          iort_node->length);
> @@ -1069,25 +1077,23 @@ static void iort_find_rmrs(struct acpi_iort_node =
*iommu, struct device *dev,
>   * If dev is NULL, the function populates all the RMRs associated with t=
he
>   * given IOMMU.
>   */
> -static void iort_iommu_rmr_get_resv_regions(struct fwnode_handle *iommu_=
fwnode,
> -                                           struct device *dev,
> -                                           struct list_head *head)
> +static void iort_iommu_rmr_get_resv_regions(struct iort_resv_args *args)
>  {
>         struct acpi_iort_node *iommu;
>
> -       iommu =3D iort_get_iort_node(iommu_fwnode);
> +       iommu =3D iort_get_iort_node(args->iommu_fwnode);
>         if (!iommu)
>                 return;
>
> -       iort_find_rmrs(iommu, dev, head);
> +       iort_find_rmrs(args, iommu);
>  }
>
> -static struct acpi_iort_node *iort_get_msi_resv_iommu(struct device *dev=
)
> +static struct acpi_iort_node *
> +iort_get_msi_resv_iommu(struct iort_resv_args *args)
>  {
>         struct acpi_iort_node *iommu;
> -       struct iommu_fwspec *fwspec =3D dev_iommu_fwspec_get(dev);
>
> -       iommu =3D iort_get_iort_node(fwspec->iommu_fwnode);
> +       iommu =3D iort_get_iort_node(args->iommu_fwnode);
>
>         if (iommu && (iommu->type =3D=3D ACPI_IORT_NODE_SMMU_V3)) {
>                 struct acpi_iort_smmu_v3 *smmu;
> @@ -1105,15 +1111,13 @@ static struct acpi_iort_node *iort_get_msi_resv_i=
ommu(struct device *dev)
>   * The ITS interrupt translation spaces (ITS_base + SZ_64K, SZ_64K)
>   * associated with the device are the HW MSI reserved regions.
>   */
> -static void iort_iommu_msi_get_resv_regions(struct device *dev,
> -                                           struct list_head *head)
> +static void iort_iommu_msi_get_resv_regions(struct iort_resv_args *args)
>  {
> -       struct iommu_fwspec *fwspec =3D dev_iommu_fwspec_get(dev);
>         struct acpi_iort_its_group *its;
>         struct acpi_iort_node *iommu_node, *its_node =3D NULL;
>         int i;
>
> -       iommu_node =3D iort_get_msi_resv_iommu(dev);
> +       iommu_node =3D iort_get_msi_resv_iommu(args);
>         if (!iommu_node)
>                 return;
>
> @@ -1126,9 +1130,9 @@ static void iort_iommu_msi_get_resv_regions(struct =
device *dev,
>          * a given PCI or named component may map IDs to.
>          */
>
> -       for (i =3D 0; i < fwspec->num_ids; i++) {
> +       for (i =3D 0; i < args->fw_num_ids; i++) {
>                 its_node =3D iort_node_map_id(iommu_node,
> -                                       fwspec->ids[i],
> +                                       args->fw_ids[i],
>                                         NULL, IORT_MSI_TYPE);
>                 if (its_node)
>                         break;
> @@ -1151,7 +1155,7 @@ static void iort_iommu_msi_get_resv_regions(struct =
device *dev,
>                                                          prot, IOMMU_RESV=
_MSI,
>                                                          GFP_KERNEL);
>                         if (region)
> -                               list_add_tail(&region->list, head);
> +                               list_add_tail(&region->list, args->head);
>                 }
>         }
>  }
> @@ -1160,13 +1164,24 @@ static void iort_iommu_msi_get_resv_regions(struc=
t device *dev,
>   * iort_iommu_get_resv_regions - Generic helper to retrieve reserved reg=
ions.
>   * @dev: Device from iommu_get_resv_regions()
>   * @head: Reserved region list from iommu_get_resv_regions()
> + * @iommu_fwnode: fwnode that describes the iommu connection for the dev=
ice
> + * @fw_ids: Parsed IDs
> + * @fw_num_ids: Length of fw_ids
>   */
> -void iort_iommu_get_resv_regions(struct device *dev, struct list_head *h=
ead)
> +void iort_iommu_get_resv_regions(struct device *dev, struct list_head *h=
ead,
> +                                struct fwnode_handle *iommu_fwnode,
> +                                const u32 *fw_ids, unsigned int fw_num_i=
ds)
>  {
> -       struct iommu_fwspec *fwspec =3D dev_iommu_fwspec_get(dev);
> +       struct iort_resv_args args =3D {
> +               .dev =3D dev,
> +               .head =3D head,
> +               .iommu_fwnode =3D iommu_fwnode,
> +               .fw_ids =3D fw_ids,
> +               .fw_num_ids =3D fw_num_ids,
> +       };
>
> -       iort_iommu_msi_get_resv_regions(dev, head);
> -       iort_iommu_rmr_get_resv_regions(fwspec->iommu_fwnode, dev, head);
> +       iort_iommu_msi_get_resv_regions(&args);
> +       iort_iommu_rmr_get_resv_regions(&args);
>  }
>
>  /**
> @@ -1178,7 +1193,12 @@ void iort_iommu_get_resv_regions(struct device *de=
v, struct list_head *head)
>  void iort_get_rmr_sids(struct fwnode_handle *iommu_fwnode,
>                        struct list_head *head)
>  {
> -       iort_iommu_rmr_get_resv_regions(iommu_fwnode, NULL, head);
> +       struct iort_resv_args args =3D {
> +               .head =3D head,
> +               .iommu_fwnode =3D iommu_fwnode,
> +       };
> +
> +       iort_iommu_rmr_get_resv_regions(&args);
>  }
>  EXPORT_SYMBOL_GPL(iort_get_rmr_sids);
>
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 85163a83df2f68..d644b0502ef48e 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -468,9 +468,12 @@ void iommu_put_dma_cookie(struct iommu_domain *domai=
n)
>   */
>  void iommu_dma_get_resv_regions(struct device *dev, struct list_head *li=
st)
>  {
> +       struct iommu_fwspec *fwspec =3D dev_iommu_fwspec_get(dev);
>
> -       if (!is_of_node(dev_iommu_fwspec_get(dev)->iommu_fwnode))
> -               iort_iommu_get_resv_regions(dev, list);
> +       if (!is_of_node(fwspec->iommu_fwnode)) {
> +               iort_iommu_get_resv_regions(dev, list, fwspec->iommu_fwno=
de,
> +                                           fwspec->ids, fwspec->num_ids)=
;
> +       }
>
>         if (dev->of_node)
>                 of_iommu_get_resv_regions(dev, list);
> diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
> index 5423abff9b6b09..13f0cefb930693 100644
> --- a/include/linux/acpi_iort.h
> +++ b/include/linux/acpi_iort.h
> @@ -53,7 +53,9 @@ void iort_put_rmr_sids(struct fwnode_handle *iommu_fwno=
de,
>  /* IOMMU interface */
>  int iort_dma_get_ranges(struct device *dev, u64 *size);
>  int iort_iommu_configure_id(struct device *dev, const u32 *id_in);
> -void iort_iommu_get_resv_regions(struct device *dev, struct list_head *h=
ead);
> +void iort_iommu_get_resv_regions(struct device *dev, struct list_head *h=
ead,
> +                                struct fwnode_handle *iommu_fwnode,
> +                                const u32 *fw_ids, unsigned int fw_num_i=
ds);
>  phys_addr_t acpi_iort_dma_get_max_cpu_address(void);
>  #else
>  static inline u32 iort_msi_map_id(struct device *dev, u32 id)
> @@ -72,7 +74,9 @@ static inline int iort_dma_get_ranges(struct device *de=
v, u64 *size)
>  static inline int iort_iommu_configure_id(struct device *dev, const u32 =
*id_in)
>  { return -ENODEV; }
>  static inline
> -void iort_iommu_get_resv_regions(struct device *dev, struct list_head *h=
ead)
> +void iort_iommu_get_resv_regions(struct device *dev, struct list_head *h=
ead,
> +                                struct fwnode_handle *iommu_fwnode,
> +                                const u32 *fw_ids, unsigned int fw_num_i=
ds)
>  { }
>
>  static inline phys_addr_t acpi_iort_dma_get_max_cpu_address(void)
> --
> 2.42.0
>

